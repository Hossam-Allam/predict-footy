class CreateTablePredictionSupport < ActiveRecord::Migration[8.0]
  def change
    unless table_exists?(:teams)
      create_table :teams do |t|
        t.string :name, null: false
        t.string :crest_url
        t.timestamps
      end
    end

    unless table_exists?(:table_predictions)
      create_table :table_predictions do |t|
        t.references :user, null: false, foreign_key: true
        t.integer :season, null: false
        t.integer :points
        t.datetime :evaluated_at
        t.timestamps
      end
    end

    add_column :table_predictions, :season, :integer, null: false, default: 2026 unless column_exists?(:table_predictions, :season)
    add_column :table_predictions, :points, :integer unless column_exists?(:table_predictions, :points)
    add_column :table_predictions, :evaluated_at, :datetime unless column_exists?(:table_predictions, :evaluated_at)
    add_column :teams, :crest_url, :string unless column_exists?(:teams, :crest_url)

    unless table_exists?(:table_prediction_entries)
      create_table :table_prediction_entries do |t|
        t.references :table_prediction, null: false, foreign_key: true
        t.references :team, null: false, foreign_key: true
        t.integer :position, null: false
        t.timestamps
      end
    end

    add_index :teams, :name, unique: true unless index_exists?(:teams, :name, unique: true)
    add_index :table_predictions, [ :user_id, :season ], unique: true unless index_exists?(:table_predictions, [ :user_id, :season ], unique: true)
    add_index :table_prediction_entries, [ :table_prediction_id, :team_id ], unique: true unless index_exists?(:table_prediction_entries, [ :table_prediction_id, :team_id ], unique: true)
    add_index :table_prediction_entries, [ :table_prediction_id, :position ], unique: true unless index_exists?(:table_prediction_entries, [ :table_prediction_id, :position ], unique: true)
  end
end
