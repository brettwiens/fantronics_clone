#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
fluidPage(
    tags$head(
      tags$style(HTML("
      body {
        background-image: url('back.png');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
      }
    ")),
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
    fluidRow(
      column(2, 
             shiny::selectizeInput(inputId = 'league_select', choices = c('NHL','NBA','MLB','CFL'), label = "League", selected = 'NHL')),
      column(2,
             shiny::uiOutput(outputId = 'team_select')),
      column(6,""),
      column(1,
             shiny::textOutput(outputId = 'Refreshed')
             ),
      column(1,
             column(11,""),
             column(1, 
                    br(),
             tags$img(src = 'BW.png', height = '50px')))
    ),
  uiOutput(outputId = 'main_ui')
)