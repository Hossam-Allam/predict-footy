class CreateMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.integer :external_id
      t.integer :season
      t.integer :matchday
      t.datetime :scheduled_at
      t.string :home
      t.string :away
      t.integer :home_goals
      t.integer :away_goals
      t.string :status

      t.timestamps
    end
  end
end
