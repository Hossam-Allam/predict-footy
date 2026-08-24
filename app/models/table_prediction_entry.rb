class TablePredictionEntry < ApplicationRecord
  belongs_to :table_prediction
  belongs_to :team

  validates :position, presence: true, inclusion: { in: 1..20 }
  validates :team_id, uniqueness: { scope: :table_prediction_id }
  validates :position, uniqueness: { scope: :table_prediction_id }
end
