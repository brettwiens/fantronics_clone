#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

server <- function(input, output, session) {

  session$userData <- reactiveValues(team = NULL, current_NHL_game = NULL)
  # time_wait <- reactiveVal(0)
  # refresh_trigger <- reactiveVal(0)
  # refresh_interval <- reactiveVal(10000)  # Default to 10 seconds
  
  observeEvent(input$league_select, {
    if (input$league_select == 'NHL') {
      output$team_select <- renderUI(shiny::selectizeInput(inputId = 'NHL_team_select',
                                                           choices = unique(nhl_teams$Short_Name),
                                                           label = "Select Team",
                                                           selected = 'CGY'))
    }
  })
    # } else if (input$league_select == 'NBA') {
    #   output$team_select <- renderUI(shiny::selectizeInput(inputId = 'NBA_team_select',
    #                                                        choices = unique(nba_teams$Short_Name),
    #                                                        label = "Select Team",
    #                                                        selected = 'TOR'))
    # } else if (input$league_select == 'MLB') {
    #   output$team_select <- renderUI(shiny::selectizeInput(inputId = 'MLB_team_select',
    #                                                        choices = unique(mlb_teams$Short_Name),
    #                                                        label = "Select Team",
    #                                                        selected = 'TOR'))
    # } else if  (input$league_select == 'CFL') {
    #   output$team_select <- renderUI(shiny::selectizeInput(inputId = 'CFL_team_select',
    #                                                        choices = unique(cfl_teams$Short_Name),
    #                                                        label = "Select Team",
    #                                                        selected = 'CGY'))
    # }
  
  # time_wait <- 10000
  # auto_refresh <- reactiveTimer(time_wait)  # Dynamic refresh interval
  #### NHL Server ####

  observeEvent(input$NHL_team_select, {
    session$userData$team <- input$NHL_team_select
    session$userData$current_NHL_game <- current_NHL_game(session$userData$team, time_zone)
    print(paste("Team:", input$NHL_team_select))
    # invalidateLater(1, session)
    # refresh_trigger(refresh_trigger() + 1)
    output$main_ui <- renderUI(generate_nhl_ui(session))
    
  })

  # observeEvent(input$MLB_team_select, {
  #   session$userData$team <- input$MLB_team_select
  #   session$userData$current_MLB_game <- current_MLB_game(session$userData$team, time_zone)
  #   # invalidateLater(1, session)
  #   refresh_trigger(refresh_trigger() + 1)
  #   output$main_ui <- renderUI(generate_mlb_ui(session))
  # })

  # observe({
  #   req(input$league_select == 'NHL')
  #   req(input$team_select %in% nhl_teams$Short_Name)
  #   print("Getting Updates")
  #   refresh_trigger(refresh_trigger() + 1)
  #   session$userData$current_NHL_game <- current_NHL_game(session$userData$team, time_zone)
  # })

  # observe({
  #   req(input$league_select == 'MLB')
  #   req(input$MLB_team_select)
  #   print("Getting Updates")
  #   refresh_trigger(refresh_trigger() + 1)
  #   session$userData$current_MLB_game <- current_MLB_game(session$userData$team, time_zone)
  # })

  observe({
    req(input$NHL_team_select %in% nhl_teams$Short_Name)


    
    # Compute time until next game
    time_diff <- max(0, as.numeric(difftime(
      as.POSIXct(session$userData$current_NHL_game$current_game_data$local_time, 
                 format = "%Y-%m-%d %H:%M:%S %Z"), 
      Sys.time(), 
      units = 'secs')) * 1000)
    
    if (time_diff > 0) {
      # Future game: Set refresh interval
      time_wait <- max(time_diff, 10000)
      output$seconds_to_game <- renderText(convert_milliseconds(time_diff))
      
      # isolate({ invalidateLater(time_wait, session) })
      # refresh_interval(time_wait)
      print(paste('Scheduled, waiting', convert_milliseconds(time_wait)))
      auto_refresh <- reactiveTimer(time_wait)
      auto_refresh()
      
    } else if (session$userData$current_NHL_game$game_information$game_state == 'FINAL') {
      # Game finished: Long refresh interval
      time_wait <- 10000000
      # isolate({ invalidateLater(time_wait, session) })
      # refresh_interval(time_wait)
      print(paste('Game Complete: Waiting', time_wait / 1000, 'seconds'))
      auto_refresh <- reactiveTimer(time_wait)
      auto_refresh()
    } else if (session$userData$current_NHL_game$game_information$game_state == 'LIVE') {
      # Live game: Refresh every 10 seconds
      time_wait <- 10000  # 10 seconds
      # isolate({ invalidateLater(time_wait, session) })
      # refresh_interval(time_wait)
      print(paste('Game Active: Refresh in', time_wait / 1000, 'seconds'))
      auto_refresh <- reactiveTimer(time_wait)
      auto_refresh()
      # Get current game data
      session$userData$current_NHL_game <- current_NHL_game(session$userData$team, time_zone)
      
      # Update UI
      output$main_ui <- renderUI(generate_nhl_ui(session))
    }
  })


  #### CFL SERVER ####



  #### MLB SERVER ####



  #### NBA SERVER ####



  #### ####

}


