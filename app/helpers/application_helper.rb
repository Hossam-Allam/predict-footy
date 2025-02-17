module ApplicationHelper
  TEAM_LOGO_MAP = {
    "Arsenal FC" => "arsenal.png",
    "Manchester City FC" => "manchester city.png",
    "Manchester United FC" => "manchester united.png",
    "Aston Villa FC" => "aston villa.png",
    "Liverpool FC" => "liverpool.png",
    "Leicester City FC" => "leicester.png",
    "Brentford FC" => "brentford.png",
    "Everton FC" => "everton.png",
    "West Ham United FC" => "west ham.png",
    "Ipswich Town FC" => "ipswich.png",
    "Tottenham Hotspur FC" => "tottenham.png",
    "AFC Bournemouth" => "bournemouth.png",
    "Wolverhampton Wanderers FC" => "wolverhampton wanderers.png",
    "Southampton FC" => "southampton.png",
    "Brighton & Hove Albion FC" => "brighton.png",
    "Fulham FC" => "fulham.png",
    "Crystal Palace FC" => "crystal palace.png",
    "Chelsea FC" => "chelsea.png",
    "Newcastle United FC" => "newcastle.png",
    "Nottingham Forest FC" => "nottingham forest.png"

  }.freeze

  def team_logo(team_name)
    logo = TEAM_LOGO_MAP[team_name] || "default-team.png"
    image_tag("teams/#{logo}", class: "team-logo")
  end
end
