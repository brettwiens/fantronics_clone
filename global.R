library(httr)
library(jsonlite)
library(dplyr)
library(data.table)
library(lubridate)

source('www/support_functions.R')
source('www/ui_generator.R')
# source('www/styles.css')

team <- 'TOR'
time_zone <- Sys.timezone()

# Get today's date in NHL API format
today <- format(Sys.Date(), "%Y-%m-%d")
api_base <- 'https://api-web.nhle.com/v1'

current_schedule_game <- function(team, time_zone){
  
  # Fetch the NHL schedule for today
  schedule_url <- paste0(api_base, "/club-schedule-season/",team,"/now")
  response <- GET(schedule_url)
  
  if (status_code(response) == 200) {
    schedule_data <- fromJSON(content(response, "text"), flatten = TRUE)
    
    if (nrow(schedule_data$games) > 0) {
      todays_game <- head(schedule_data$games[schedule_data$games$gameDate >= today, ], 1)
      
      game_information <- list()
      
      game_information$home_logo <- todays_game$homeTeam.darkLogo
      game_information$away_logo <- todays_game$awayTeam.darkLogo
      game_information$home_team_place <- todays_game$homeTeam.placeName.default
      game_information$home_team_common <- todays_game$homeTeam.commonName.default
      game_information$away_team_place <- todays_game$awayTeam.placeName.default
      game_information$away_team_common <- todays_game$awayTeam.commonName.default
      game_information$venue <- paste0(todays_game$venue.default,", ",todays_game$homeTeam.placeName.default)
      
      game_information$game_id <- todays_game$id
      boxscore <- paste0(api_base, '/gamecenter/', game_information$game_id, '/boxscore')
      game_information$boxscore <- paste0(api_base, '/gamecenter/', game_information$game_id, '/boxscore')
      
      current_game_data <- get_current_game(game_information$boxscore, time_zone)

      game_information$game_time <- current_game_data$local_time
      
      return(list(current_game_data = current_game_data, game_information = game_information))
      
      } else {
      status <- paste("No", team, "games scheduled today.")
    }
  } else {
    status <- paste("Error reading API")
  }
}

get_current_game <- function(boxscore, time_zone){
  response <- GET(boxscore)
  if (status_code(response) == 200) {
    game_data <- fromJSON(content(response, "text"), flatten = TRUE)
  }
  
  home_score <- game_data$homeTeam$score
  away_score <- game_data$awayTeam$score
  
  home_shots <- game_data$homeTeam$sog
  away_shots <- game_data$awayTeam$sog
  
  utc_time <- ymd_hms(game_data$startTimeUTC, tz = 'UTC')
  # Convert to Mountain Time (Handles MST/MDT Automatically)
  local_time <- with_tz(utc_time, time_zone)
  
  # print(game_data$clock)
  
  if (game_data$clock$inIntermission) {
    game_time <- "Intermission"
  } else if (game_data$clock$secondsRemaining > 0) {
    game_time <- game_data$clock$timeRemaining  
  } else if (local_time > Sys.time()) {
    game_time <- "Scheduled"
  } else {
    game_time <- 'Final'
  }
  
  if (game_time == 'Final' | game_time == 'Scheduled') {
    period <- ""
    power_play <- ""
    home_strength <- NULL
    away_strength <- NULL
  } else {
    period <- ifelse(game_data$clock$Intermission, "", paste('Period:', game_data$periodDescriptor$number))
    home_strength <- game_data$situation$homeTeam$strength
    away_strength <- game_data$situation$awayTeam$strength
    
    if (is.null(home_strength) | is.null(away_strength)) {
      power_play <- "Even Strength"
    }
    else {
      if (home_strength > away_strength & home_strength != 6) {
        power_play <- paste(game_data$homeTeam$commonName, "Power Play")
      } else if (away_strength > home_strength & away_strength != 6) {
        power_play <- paste(game_data$awayTeam$commonName, "Power Play")
      } else {
        power_play <- "Empty Net"
      }
    }
  }
  
  scoring <- list()
  
  #### GOALS ####
  scoring$home_goal_scorers <- rbind(
    game_data$playerByGameStats$homeTeam$forwards[game_data$playerByGameStats$homeTeam$forwards$goals > 0, c('name.default', 'goals')],
    game_data$playerByGameStats$homeTeam$defense[game_data$playerByGameStats$homeTeam$defense$goals > 0, c('name.default', 'goals')]
    # game_data$playerByGameStats$homeTeam$goalies[game_data$playerByGameStats$homeTeam$goalies$goals > 0, c('name.default', 'goals')]
  )
  scoring$home_goal_scorers$summary <- paste(scoring$home_goal_scorers$name.default, scoring$home_goal_scorers$goals)
  scoring$home_goal_text <- paste(scoring$home_goal_scorers$summary, collapse = ", ")
  
  scoring$away_goal_scorers <- rbind(
    game_data$playerByGameStats$awayTeam$forwards[game_data$playerByGameStats$awayTeam$forwards$goals > 0, c('name.default', 'goals')],
    game_data$playerByGameStats$awayTeam$defense[game_data$playerByGameStats$awayTeam$defense$goals > 0, c('name.default', 'goals')]
    # game_data$playerByGameStats$awayTeam$goalies[game_data$playerByGameStats$awayTeam$goalies$assists > 0, c('name.default', 'assists')]
  )
  scoring$away_goal_scorers$summary <- paste(scoring$away_goal_scorers$name.default, scoring$away_goal_scorers$goals)
  scoring$away_goal_text <- paste(scoring$away_goal_scorers$summary, collapse = ", ")
  
  #### ASSISTS ####
  scoring$home_goal_assists <- rbind(
    game_data$playerByGameStats$homeTeam$forwards[game_data$playerByGameStats$homeTeam$forwards$assists > 0, c('name.default', 'assists')],
    game_data$playerByGameStats$homeTeam$defense[game_data$playerByGameStats$homeTeam$defense$assists > 0, c('name.default', 'assists')]
    # game_data$playerByGameStats$homeTeam$goalies[game_data$playerByGameStats$homeTeam$goalies$goals > 0, c('name.default', 'goals')]
  )
  scoring$home_goal_assists$summary <- paste(scoring$home_goal_assists$name.default, scoring$home_goal_assists$assists)
  scoring$home_assists_text <- paste(scoring$home_goal_assists$summary, collapse = ", ")
  
  scoring$away_goal_assists <- rbind(
    game_data$playerByGameStats$awayTeam$forwards[game_data$playerByGameStats$awayTeam$forwards$assists > 0, c('name.default', 'assists')],
    game_data$playerByGameStats$awayTeam$defense[game_data$playerByGameStats$awayTeam$defense$assists > 0, c('name.default', 'assists')]
    # game_data$playerByGameStats$awayTeam$goalies[game_data$playerByGameStats$awayTeam$goalies$assists > 0, c('name.default', 'assists')]
  )
  scoring$away_goal_assists$summary <- paste(scoring$away_goal_assists$name.default, scoring$away_goal_assists$assists) 
  scoring$away_assists_text <- paste(scoring$away_goal_assists$summary, collapse = ", ")
  
  ####
  
  return(list(home_score = home_score, away_score = away_score, home_shots = home_shots, away_shots = away_shots, local_time = local_time, game_time = game_time, period = period,
              home_strength = home_strength, away_strength = away_strength, power_play = power_play, scoring = scoring))
}

# current_schedule <- current_schedule_game(team, time_zone)
