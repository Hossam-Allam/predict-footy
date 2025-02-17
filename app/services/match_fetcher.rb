require "httparty"

class MatchFetcher
  include HTTParty
  base_uri "api.football-data.org/v4"

  def initialize
    @headers = {
      "X-Auth-Token" => ENV["FOOTBALL_API_KEY"]
    }
  end

  def fetch_matches
    response = self.class.get("/competitions/PL/matches?status=SCHEDULED", headers: @headers)

    if response.success?
      matches = response.parsed_response["matches"]
      matches.each do |m|
        match = Match.find_or_initialize_by(external_id: m["id"])
        match.season      = Date.parse(m["utcDate"]).year
        match.matchday    = m["matchday"]
        match.scheduled_at = m["utcDate"]
        match.home        = m["homeTeam"]["name"]
        match.away        = m["awayTeam"]["name"]

        if m["status"] == "FINISHED"
          match.home_goals = m["score"]["fullTime"]["homeTeam"]
          match.away_goals = m["score"]["fullTime"]["awayTeam"]
        end
        match.status      = m["status"]
        match.save!
      end
    else
      Rails.logger.error("Failed to fetch matches: #{response.code} #{response.message}")
    end
  end
end
