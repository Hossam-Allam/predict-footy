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
    response = self.class.get("/competitions/PL/matches", headers: @headers)

    if response.success?
      matches = response.parsed_response["matches"]
      matches.each do |m|
        match = Match.find_or_initialize_by(external_id: m["id"])
        match.season      = ENV["CURRENT_SEASON"].to_i
        match.matchday    = m["matchday"]
        match.scheduled_at = m["utcDate"]
        match.home        = m["homeTeam"]["name"]
        match.away        = m["awayTeam"]["name"]
        match.home_crest  = m["homeTeam"]["crest"]
        match.away_crest  = m["awayTeam"]["crest"]

        if m["status"] == "FINISHED"
          match.home_goals = m["score"]["fullTime"]["home"]
          match.away_goals = m["score"]["fullTime"]["away"]
        end
        unless match.status.to_s.upcase.strip == "FINISHED"
          match.status = m["status"].to_s.upcase.strip
        end
        match.save!
      end
    else
      Rails.logger.error("Failed to fetch matches: #{response.code} #{response.message}")
    end
  end
end
