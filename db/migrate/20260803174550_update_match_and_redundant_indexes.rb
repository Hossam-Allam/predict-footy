class UpdateMatchAndRedundantIndexes < ActiveRecord::Migration[8.0]
  def change
    add_index :matches, :status

    remove_index :league_memberships,
                 name: "index_league_memberships_on_user_id"

    remove_index :predictions,
                 name: "index_predictions_on_user_id"
  end
end
