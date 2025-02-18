class AddUniqueIndexToLeagueMemberships < ActiveRecord::Migration[8.0]
  def change
    add_index :league_memberships, [ :user_id, :league_id ], unique: true
  end
end
