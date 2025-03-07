
observeEvent(input$teamSelect, {
  session$userData$team <- input$teamSelect
  session$userData$current_schedule <- current_NHL_game(session$userData$team, time_zone)
  # invalidateLater(1, session)
  refresh_trigger(refresh_trigger() + 1)
  output$main_ui <- renderUI(generate_ui(session))
})

observe({
  print("Getting Updates")
  session$userData$current_schedule <- current_NHL_game(session$userData$team, time_zone)
})

observe({
  req(input$teamSelect)
  req(session$userData$current_schedule$current_game_data$local_time)
  
  refresh_trigger()
  
  time_diff <- max(0, as.numeric(difftime(as.POSIXct(session$userData$current_schedule$current_game_data$local_time, format = "%Y-%m-%d %H:%M:%s %Z"), Sys.time(), units = 'secs')) * 1000)
  print(session$userData$current_schedule$current_game_data$game_time)
  if (time_diff > 0) {
    # current_schedule <- current_NHL_game(team, time_zone)
    time_wait <- max(time_diff, 10000)
    output$seconds_to_game <- renderText(convert_milliseconds(time_diff))
    
    isolate({
      invalidateLater(time_wait, session)
    })
    
    session$userData$current_schedule <- current_NHL_game(session$userData$team, time_zone)
    print(paste('Waiting', time_wait / 1000, 'seconds'))
  } else if (session$userData$current_schedule$current_game_data$game_time == 'Final') {
    time_wait <- 10000000
    
    isolate({
      invalidateLater(time_wait, session)
    })
    
    print(paste('Game Complete: Waiting', time_wait / 1000, 'seconds'))
  } else {
    # current_schedule <- current_NHL_game(team, time_zone)
    time_wait <- 10000 # 10 seconds
    
    isolate({
      invalidateLater(time_wait, session)
    })
    
    session$userData$current_schedule <- current_NHL_game(session$userData$team, time_zone)
    print('Game on, waiting 10 seconds')
    # print(current_NHL_game())
  }
  
  output$main_ui <- renderUI(generate_ui(session))
})