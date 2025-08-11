class AddSeasonToLeagueMemberships < ActiveRecord::Migration[8.0]
  def change
    add_column :league_memberships, :season, :integer
  end
end
