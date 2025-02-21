class CreatePredictions < ActiveRecord::Migration[8.0]
  def change
    create_table :predictions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.integer :home_score
      t.integer :away_score
      t.integer :points_awarded

      t.timestamps
    end
  end
end
