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


  def team_logo(team_name, crest_url = nil)
    if (logo_filename = TEAM_LOGO_MAP[team_name])
      image_tag("teams/#{logo_filename}", class: "team-logo")
    elsif crest_url.present?
      image_tag(crest_url, class: "team-logo")
    else
      image_tag(
        "http://img.freepik.com/premium-vector/vector-football-logo-football-logo-football-club-sign_627382-60.jpg",
        class: "team-logo"
      )
    end
  end
end
