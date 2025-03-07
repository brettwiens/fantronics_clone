generate_mlb_ui <- function(session){
  
  test <<- session$userData$current_MLB_game
  return(
    div(
      hr(),
      fluidRow(
        column(3, class = "score-container", 
               box(
                 title = div(class = 'score-title', "Away"),
                 width = 6, 
                 solidHeader = TRUE, 
                 status = "primary",      
                 div(class = "score-box",
                     div(class = "team-name", session$userData$current_MLB_game$away_team),
                     br(),
                     hr(),
                     br(),
                     tags$img(src = session$userData$current_MLB_game$away_logo, height = '100px'),
                     div(class = 'shots', paste0(session$userData$current_MLB_game$away_record$wins, "-", session$userData$current_MLB_game$away_record$losses))
                 ))),
        column(2, 
               div(class = 'mlb_score', session$userData$current_MLB_game$away_score)
        ),
        column(2, class = "info-container",
               
               br(),
               br(),
               br(),
               box(
                 title = div(class = 'score-title', "Game Information"),
                 width = 20,
                 solidHeader = TRUE,
                 status = "primary",
                 div(class = 'info-box',
                     div(class = 'venue', session$userData$current_MLB_game$venue),
                     hr(),
                     div(class = 'game-time', paste(session$userData$current_MLB_game$game_time)),
                     hr(), 
                     div(class = 'period', paste0(session$userData$current_MLB_game$livedata$innings$top_bot_inning, " ", 
                                                  session$userData$current_MLB_game$livedata$innings$inning))
                 )
                 )
               ),
        column(2, 
               div(class = 'mlb_score', session$userData$current_MLB_game$home_score)
        ),
        column(3, class = "score-container", 
               box(
                 title = div(class = 'score-title', "Home"),
                 width = 6, 
                 solidHeader = TRUE, 
                 status = "primary",      
                 div(class = "score-box",
                     div(class = "team-name", session$userData$current_MLB_game$home_team),
                     br(),
                     hr(),
                     br(),
                     tags$img(src = session$userData$current_MLB_game$home_logo, height = '100px'),
                     div(class = 'shots', paste0(session$userData$current_MLB_game$home_record$wins, "-", session$userData$current_MLB_game$home_record$losses))
                 ))),
        
      )
    )
  )
}