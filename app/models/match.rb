class Match < ApplicationRecord
  has_many :predictions, dependent: :destroy
  validates :external_id, presence: true, uniqueness: true
end
