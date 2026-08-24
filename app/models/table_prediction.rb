class TablePrediction < ApplicationRecord
  LOCK_TIME_ZONE = "Africa/Cairo".freeze

  belongs_to :user
  has_many :entries, class_name: "TablePredictionEntry", dependent: :destroy

  validates :season, presence: true, uniqueness: { scope: :user_id }

  def self.lock_at_for(season)
    configured_date = ENV["TABLE_PREDICTION_LOCK_AT"]
    return Time.iso8601(configured_date) if configured_date.present?

    # Predictions remain open for all of 2 September, then close at midnight
    # at the start of 3 September in Egypt's official timezone.
    lock_time_zone.local(season, 9, 3)
  end

  def self.lock_time_zone
    Time.find_zone!(LOCK_TIME_ZONE)
  end

  def lock_at
    self.class.lock_at_for(season)
  end

  def lock_at_label
    lock_at.in_time_zone(self.class.lock_time_zone).strftime("%-d %B %Y at %-I:%M %p %Z")
  end

  def editable?
    Time.current < lock_at
  end

  def replace_entries!(team_ids, allowed_team_ids:)
    raise ActiveRecord::RecordInvalid, self unless editable?

    normalized_ids = team_ids.map(&:to_i)
    valid_set = normalized_ids.length == 20 && normalized_ids.uniq.length == 20 && normalized_ids.sort == allowed_team_ids.map(&:to_i).sort
    unless valid_set
      errors.add(:entries, "must contain each of the 20 current teams exactly once")
      raise ActiveRecord::RecordInvalid, self
    end

    transaction do
      save! if new_record?
      entries.delete_all
      normalized_ids.each_with_index do |team_id, index|
        entries.create!(team_id: team_id, position: index + 1)
      end
    end
  end
end
