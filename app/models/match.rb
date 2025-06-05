class Match < ApplicationRecord
  has_many :predictions, dependent: :destroy
  validates :external_id, presence: true, uniqueness: true

  scope :upcoming, -> {
    where(status: "TIMED")
      .order(scheduled_at: :asc)
  }

  scope :finished, -> {
    where(status: "FINISHED")
      .order(scheduled_at: :desc)
  }
end
