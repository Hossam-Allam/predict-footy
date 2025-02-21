class AddUniqueIndexToPredictions < ActiveRecord::Migration[8.0]
  def change
    add_index :predictions, [ :user_id, :match_id ], unique: true
  end
end
