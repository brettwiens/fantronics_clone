# install.packages('httr')

library(httr)
library(jsonlite)
library(dplyr)
library(data.table)
library(lubridate)

source('www/support_functions.R')
source('www/nhl_ui_generator.R')
source('www/mlb_ui_generator.R')
source('www/team_stuff.R')
source('www/nhl_stat_collector.R')
source('www/mlb_stat_collector.R')

time_zone <- Sys.timezone()

# Get today's date in NHL API format
today <- format(Sys.Date(), "%Y-%m-%d")


