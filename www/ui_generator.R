generate_ui <- function(session){
  return(
    div(
      br(),
      br(),
      br(),
      fluidRow(
        # column(1,""),
        column(4, class = "score-container", 
               box(
                 title = div(class = 'score-title', "Away"),
                 width = 6, 
                 solidHeader = TRUE, 
                 status = "primary",      
                 div(class = "score-box",
                     div(class = "team-name", session$userData$current_schedule$game_information$away_team_place),
                     div(class = "team-name", session$userData$current_schedule$game_information$away_team_common),
                     hr(),
                     tags$img(src = session$userData$current_schedule$game_information$away_logo),
                     div(class = "score", session$userData$current_schedule$current_game_data$away_score),
                     div(class = 'shots', ifelse(session$userData$current_schedule$current_game_data$game_time == 'Scheduled', "", 
                                                 paste("Shots:", session$userData$current_schedule$current_game_data$away_shots)))
                 ))),
        column(4,
               fluidRow(
                 column(3, ""),
                 column(6,
                        box(
                          title = div(class = 'score-title', "Game Information"),
                          width = 20,
                          solidHeader = TRUE,
                          status = "primary",
                          div(class = 'info-box',
                              div(class = 'venue', session$userData$current_schedule$game_information$venue),
                              # div(class = 'team-name', current_schedule$game_information$game_id),
                              hr(),
                              div(class = 'game-time', paste(session$userData$current_schedule$game_information$game_time, format(Sys.time(), '%Z'))),
                              conditionalPanel(
                                condition = "session$userData$current_schedule$current_game_data$game_time == 'Scheduled'",
                                div(
                                  br(),
                                  div(class = 'game-time', textOutput(outputId = 'seconds_to_game'))
                                ) 
                              ),
                              hr(), 
                              div(class = 'time_remaining', session$userData$current_schedule$current_game_data$game_time),
                              div(class = 'period', session$userData$current_schedule$current_game_data$period),
                              div(class = 'power_play', session$userData$current_schedule$current_game_data$power_play),
                              div(class = 'strength', ifelse(!is.null(session$userData$current_schedule$current_game_data$home_strength), 
                                                             paste(session$userData$current_schedule$current_game_data$away_strength, "-", 
                                                                   session$userData$current_schedule$current_game_data$home_strength), "")
                              ))
                        )),
                 column(3,"")),
               fluidRow(
                 column(6, 
                        box(
                          title = div(class = 'score-title', 'Away Scoring'),
                          solidHeader = TRUE,
                          status = 'primary',
                          div(class = 'scoring-box',
                              div(class = 'scoring',
                                  h4("Goals"),
                                  session$userData$current_schedule$current_game_data$scoring$away_goal_text,
                                  h4("Assists"),
                                  session$userData$current_schedule$current_game_data$scoring$away_assists_text
                              )
                          )
                        )
                 ),
                 column(6,
                        box(
                          title = div(class = 'score-title', 'Home Scoring'),
                          solidHeader = TRUE,
                          status = 'primary',
                          div(class = 'scoring-box',
                              div(class = 'scoring',
                                  h4("Goals"),
                                  session$userData$current_schedule$current_game_data$scoring$home_goal_text,
                                  h4("Assists"),
                                  session$userData$current_schedule$current_game_data$scoring$home_assists_text
                              )
                          )
                        )
                 )
               )),
        column(4, class = "score-container", 
               box(
                 title = div(class = 'score-title', "Home"),
                 width = 6, 
                 solidHeader = TRUE, 
                 status = "primary",      
                 div(class = "score-box",
                     div(class = "team-name", session$userData$current_schedule$game_information$home_team_place),
                     div(class = "team-name", session$userData$current_schedule$game_information$home_team_common),
                     hr(),
                     tags$img(src = session$userData$current_schedule$game_information$home_logo),
                     div(class = "score", session$userData$current_schedule$current_game_data$home_score),
                     div(class = 'shots', ifelse(session$userData$current_schedule$current_game_data$game_time == 'Scheduled', "", 
                                                 paste("Shots:", session$userData$current_schedule$current_game_data$home_shots)))
                 )))
        # column(1,"")
      )))
}
