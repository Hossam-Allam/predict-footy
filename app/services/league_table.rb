class LeagueTable
  Row = Data.define(:team, :played, :won, :drawn, :lost, :goals_for, :goals_against, :points, :position)

  def initialize(teams:, season:)
    @teams = teams
    @season = season
  end

  def positions
    return {} unless Match.where(season: season, status: "FINISHED").exists?

    rows.index_by { |row| row.team.id }.transform_values(&:position)
  end

  private

  attr_reader :teams, :season

  def rows
    records = teams.index_with { { played: 0, won: 0, drawn: 0, lost: 0, goals_for: 0, goals_against: 0, points: 0 } }
    teams_by_name = teams.index_by(&:name)

    Match.where(season: season, status: "FINISHED").find_each do |match|
      home_team = teams_by_name[match.home]
      away_team = teams_by_name[match.away]
      next if home_team.blank? || away_team.blank? || match.home_goals.nil? || match.away_goals.nil?

      apply_result(records[home_team], records[away_team], match.home_goals, match.away_goals)
    end

    records.sort_by { |team, record| [ -record[:points], -(record[:goals_for] - record[:goals_against]), -record[:goals_for], team.name ] }
           .each_with_index.map { |(team, record), index| Row.new(team: team, **record, position: index + 1) }
  end

  def apply_result(home, away, home_goals, away_goals)
    [ [ home, home_goals, away_goals ], [ away, away_goals, home_goals ] ].each do |record, scored, conceded|
      record[:played] += 1
      record[:goals_for] += scored
      record[:goals_against] += conceded
      if scored > conceded
        record[:won] += 1
        record[:points] += 3
      elsif scored == conceded
        record[:drawn] += 1
        record[:points] += 1
      else
        record[:lost] += 1
      end
    end
  end
end
