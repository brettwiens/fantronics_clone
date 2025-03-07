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

nba_teams <- data.frame(
  Team = c(
    "Atlanta Hawks", "Boston Celtics", "Brooklyn Nets", "Charlotte Hornets", "Chicago Bulls",
    "Cleveland Cavaliers", "Dallas Mavericks", "Denver Nuggets", "Detroit Pistons", "Golden State Warriors",
    "Houston Rockets", "Indiana Pacers", "Los Angeles Clippers", "Los Angeles Lakers", "Memphis Grizzlies",
    "Miami Heat", "Milwaukee Bucks", "Minnesota Timberwolves", "New Orleans Pelicans", "New York Knicks",
    "Oklahoma City Thunder", "Orlando Magic", "Philadelphia 76ers", "Phoenix Suns", "Portland Trail Blazers",
    "Sacramento Kings", "San Antonio Spurs", "Toronto Raptors", "Utah Jazz", "Washington Wizards"
  ),
  Short_Name = c(
    "ATL", "BOS", "BKN", "CHA", "CHI",
    "CLE", "DAL", "DEN", "DET", "GSW",
    "HOU", "IND", "LAC", "LAL", "MEM",
    "MIA", "MIL", "MIN", "NOP", "NYK",
    "OKC", "ORL", "PHI", "PHX", "POR",
    "SAC", "SAS", "TOR", "UTA", "WAS"
  ),
  Primary_Colour = c(
    "#E03A3E", "#007A33", "#000000", "#1D1160", "#CE1141",
    "#860038", "#00538C", "#0E2240", "#C8102E", "#FFC72C",
    "#CE1141", "#002D62", "#C8102E", "#552583", "#5D76A9",
    "#98002E", "#00471B", "#0C2340", "#0C2340", "#F58426",
    "#007AC1", "#0077C0", "#006BB6", "#E56020", "#E03A3E",
    "#5A2D81", "#C4CED4", "#CE1141", "#002B5C", "#002B5C"
  ),
  Secondary_Colour = c(
    "#C1D32F", "#BA9653", "#FFFFFF", "#00788C", "#000000",
    "#041E42", "#002B5E", "#FEC524", "#006BB6", "#1D428A",
    "#000000", "#FDBB30", "#1D428A", "#FDB927", "#12173F",
    "#F9A01B", "#EEE1C6", "#236192", "#C8102E", "#006BB6",
    "#EF3B24", "#C4CED4", "#ED174C", "#1D1160", "#000000",
    "#63727A", "#000000", "#000000", "#F9A01B", "#E31837"
  ),
  stringsAsFactors = FALSE
)

mlb_teams <- data.frame(
  Team = c(
    "Arizona Diamondbacks", "Atlanta Braves", "Baltimore Orioles", "Boston Red Sox", "Chicago White Sox",
    "Chicago Cubs", "Cincinnati Reds", "Cleveland Guardians", "Colorado Rockies", "Detroit Tigers",
    "Houston Astros", "Kansas City Royals", "Los Angeles Angels", "Los Angeles Dodgers", "Miami Marlins",
    "Milwaukee Brewers", "Minnesota Twins", "New York Yankees", "New York Mets", "Oakland Athletics",
    "Philadelphia Phillies", "Pittsburgh Pirates", "San Diego Padres", "San Francisco Giants", "Seattle Mariners",
    "St. Louis Cardinals", "Tampa Bay Rays", "Texas Rangers", "Toronto Blue Jays", "Washington Nationals"
  ),
  Short_Name = c(
    "ARI", "ATL", "BAL", "BOS", "CWS",
    "CHC", "CIN", "CLE", "COL", "DET",
    "HOU", "KCR", "LAA", "LAD", "MIA",
    "MIL", "MIN", "NYY", "NYM", "OAK",
    "PHI", "PIT", "SDP", "SFG", "SEA",
    "STL", "TBR", "TEX", "TOR", "WSH"
  ),
  Primary_Colour = c(
    "#A71930", "#CE1141", "#DF4601", "#BD3039", "#27251F",
    "#0E3386", "#C6011F", "#E31937", "#33006F", "#FA4616",
    "#EB6E1F", "#004687", "#BA0021", "#005A9C", "#00A3E0",
    "#FFC52F", "#002B5C", "#003087", "#002D72", "#003831",
    "#E81828", "#FDB827", "#2F241D", "#FD5A1E", "#005C5C",
    "#C41E3A", "#8FBCE6", "#003278", "#134A8E", "#AB0003"
  ),
  Secondary_Colour = c(
    "#E3D4AD", "#13274F", "#000000", "#0C2340", "#C4CED4",
    "#CC3433", "#000000", "#0C2340", "#C4CED4", "#0C2C56",
    "#002D62", "#BD9B60", "#862633", "#EF3E42", "#FFD100",
    "#13274F", "#D31145", "#D31145", "#FF5910", "#EFB21E",
    "#002D72", "#000000", "#FFC425", "#000000", "#C4CED4",
    "#FEDB00", "#13274F", "#C0111F", "#1D2D5C", "#14225A"
  ),
  stringsAsFactors = FALSE
)

cfl_teams <- data.frame(
  Team = c(
    "BC Lions", "Calgary Stampeders", "Edmonton Elks", "Hamilton Tiger-Cats", 
    "Montreal Alouettes", "Ottawa Redblacks", "Saskatchewan Roughriders", 
    "Toronto Argonauts", "Winnipeg Blue Bombers"
  ),
  Short_Name = c(
    "BC", "CGY", "EDM", "HAM", "MTL", "OTT", "SSK", "TOR", "WPG"
  ),
  Primary_Colour = c(
    "#F37021", "#C8102E", "#007C3E", "#FFDB00", "#861F41", "#000000", "#006341", "#002C6E", "#002F6C"
  ),
  Secondary_Colour = c(
    "#000000", "#FFFFFF", "#FFB81C", "#000000", "#A0A1A2", "#C8102E", "#FFB81C", "#9A9A9A", "#FFB81C"
  ),
  stringsAsFactors = FALSE
)

