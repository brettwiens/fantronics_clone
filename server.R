#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  session$userData$current_schedule <- current_schedule_game(team, time_zone)
  
  observe({
    print("Getting Updates")
    session$userData$current_schedule <- current_schedule_game(team, time_zone)
  })
  
  observe({
    req(session$userData$current_schedule$current_game_data$local_time)
    
    time_diff <- as.numeric(difftime(as.POSIXct(session$userData$current_schedule$current_game_data$local_time, format = "%Y-%m-%d %H:%M:%s %Z"), Sys.time(), units = 'secs')) * 1000
    
    if (time_diff > 0) {
      # current_schedule <- current_schedule_game(team, time_zone)
      time_wait <- min(time_diff, 10000)
      output$seconds_to_game <- renderText(convert_milliseconds(time_diff))
      invalidateLater(time_wait, session)
      session$userData$current_schedule <- current_schedule_game(team, time_zone)
      print(paste('Waiting', time_wait / 1000, 'seconds'))
    } else {
      # current_schedule <- current_schedule_game(team, time_zone)
      invalidateLater(10000, session)
      session$userData$current_schedule <- current_schedule_game(team, time_zone)
      print('Game on, waiting 10 seconds')
    }
    
    output$main_ui <- renderUI(generate_ui(session))
    
  })
  

}
