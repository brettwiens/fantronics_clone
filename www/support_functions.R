convert_milliseconds <- function(ms) {
  seconds <- ms / 1000
  
  days <- floor(seconds / 86400)
  seconds <- seconds %% 86400
  
  hours <- floor(seconds / 3600)
  seconds <- seconds %% 3600
  
  minutes <- floor(seconds / 60)
  seconds <- seconds %% 60
  
  return(sprintf("%d days, %d hours, %d minutes, %d seconds", days, hours, minutes, floor(seconds)))
}
