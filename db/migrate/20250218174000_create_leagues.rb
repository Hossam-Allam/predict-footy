class CreateLeagues < ActiveRecord::Migration[8.0]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :unique_code
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :leagues, :unique_code, unique: true
  end
end
