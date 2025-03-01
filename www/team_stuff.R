# Create NHL teams dataframe
nhl_teams <- data.frame(
  Team = c("Anaheim Ducks", "Arizona Coyotes", "Boston Bruins", "Buffalo Sabres", "Calgary Flames",
           "Carolina Hurricanes", "Chicago Blackhawks", "Colorado Avalanche", "Columbus Blue Jackets",
           "Dallas Stars", "Detroit Red Wings", "Edmonton Oilers", "Florida Panthers", "Los Angeles Kings",
           "Minnesota Wild", "Montreal Canadiens", "Nashville Predators", "New Jersey Devils",
           "New York Islanders", "New York Rangers", "Ottawa Senators", "Philadelphia Flyers",
           "Pittsburgh Penguins", "San Jose Sharks", "Seattle Kraken", "St. Louis Blues",
           "Tampa Bay Lightning", "Toronto Maple Leafs", "Vancouver Canucks", "Vegas Golden Knights",
           "Washington Capitals", "Winnipeg Jets", "Utah Hockey Club"),
  Short_Name = c("ANA", "ARI", "BOS", "BUF", "CGY", "CAR", "CHI", "COL", 
                 "CBJ", "DAL", "DET", "EDM", "FLA", "LAK", "MIN", "MTL", 
                 "NSH", "NJD", "NYI", "NYR", "OTT", "PHI", "PIT", "SJS", 
                 "SEA", "STL", "TBL", "TOR", "VAN", "VGK", "WSH", "WPG", 
                 "UTA"),
  Primary_Colour = c("#F47A38", "#8C2633", "#FFB81C", "#002F87", "#C8102E", "#CC0000", "#CF0A2C", "#6F263D",
                     "#041E42", "#00843D", "#CE1126", "#041E42", "#041E42", "#111111", "#154734", "#AF1E2D",
                     "#FFB81C", "#CE1126", "#00539B", "#0038A8", "#E31837", "#F74902", "#FCB514", "#006D75",
                     "#355464", "#002F87", "#002868", "#00205B", "#00205B", "#B4975A", "#041E42", "#041E42",
                     "#010101"),
  Secondary_Colour = c("#B9975B", "#E2D6B5", "#000000", "#FDBB30", "#F1BE48", "#000000", "#000000", "#236192",
                       "#C8102E", "#111111", "#FFFFFF", "#FF4C00", "#B9975B", "#A2AAAD", "#A6192E", "#192168",
                       "#041E42", "#000000", "#F47D30", "#CE1126", "#C69214", "#000000", "#000000", "#EA7200",
                       "#99D9D9", "#FDBB30", "#FFFFFF", "#FFFFFF", "#00843D", "#333F42", "#C8102E", "#AC162C",
                       "#69B3E7")
)

# Display the dataframe
print(nhl_teams)
