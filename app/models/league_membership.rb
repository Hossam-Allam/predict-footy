class LeagueMembership < ApplicationRecord
  belongs_to :user
  belongs_to :league

  validates :season, presence: true
  validates :user_id, uniqueness: { scope: [ :league_id, :season ] }

  before_validation :set_default_season, on: :create

  private

  def set_default_season
    self.season ||= ::Season.current
  end
end
