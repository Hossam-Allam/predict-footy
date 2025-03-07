class AddDefaultScoresToPredictions < ActiveRecord::Migration[8.0]
  def change
    change_column_default :predictions, :home_score, 0
    change_column_default :predictions, :away_score, 0
  end
end
