class LeagueMembership < ApplicationRecord
  belongs_to :user
  belongs_to :league

  validates :user_id, uniqueness: { scope: :league_id }
end
