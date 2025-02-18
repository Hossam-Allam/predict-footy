class CreateLeagueMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :league_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :league, null: false, foreign_key: true
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
