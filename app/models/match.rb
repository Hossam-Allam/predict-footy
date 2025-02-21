class Match < ApplicationRecord
  has_many :predictions, dependent: :destroy
end
