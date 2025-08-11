class ChangeUniqueIndexOnLeagueMemberships < ActiveRecord::Migration[8.0]
  def change
    remove_index :league_memberships, column: [ :user_id, :league_id ]


    add_index :league_memberships, [ :user_id, :league_id, :season ], unique: true, name: "index_lm_on_user_league_season"
  end
end
