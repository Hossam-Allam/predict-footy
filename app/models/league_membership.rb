class LeagueMembership < ApplicationRecord
  belongs_to :user
  belongs_to :league

  validates :season, presence: true
  validates :user_id, uniqueness: { scope: [ :league_id, :season ] }

  before_validation :set_default_season, on: :create

  def self.user_ranks_for_leagues(user_id:, league_ids:, season_id:, rank_function: "RANK()")
    return {} if league_ids.blank?


    base = where(season: season_id, league_id: league_ids)


    ranked = base.select("league_memberships.*, #{rank_function} OVER (PARTITION BY league_id ORDER BY points DESC) AS rank")


    sub = from(ranked, :ranked)

    # pluck the league_id and rank from the subquery
    rows = sub.where("ranked.user_id = ?", user_id).pluck("ranked.league_id", "ranked.rank")

    # convert to hash { league_id => rank }
    rows.each_with_object({}) { |(league_id, rank), h| h[league_id.to_i] = rank.to_i }
  end

  private

  def set_default_season
    self.season ||= ::Season.current
  end
end
