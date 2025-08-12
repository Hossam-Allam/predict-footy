class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :match_id, presence: true, uniqueness: { scope: :user_id }
  validates :season, presence: true

  before_validation :set_default_season, on: :create


  scope :scored, -> {
    where.not(points_awarded: nil).order(created_at: :desc)
  }

  scope :unscored, -> {
    where(points_awarded: nil).order(created_at: :asc)
  }

  def self.stats_for_user(user)
    scored = where(user: user).scored
    total  = scored.count.nonzero? || 1

    {
      exact:      (scored.where(season: ::Season.current).where(points_awarded: 3).count.to_f  / total * 100).round(1),
      correct:    (scored.where(season: ::Season.current).where(points_awarded: 1).count.to_f  / total * 100).round(1),
      inaccurate: (scored.where(season: ::Season.current).where(points_awarded: 0).count.to_f  / total * 100).round(1)
    }
  end

  def evaluate
    return unless match.status == "FINISHED"

    new_points = calculate_points

    # First evaluation or zero points
    if self.points_awarded.nil? || self.points_awarded == 0
      self.points_awarded = new_points
      save!
      user.league_memberships.each do |membership|
        membership.increment!(:points, new_points)
      end
      # Already evaluated; if points differ, adjust the score and update league membership points accordingly.
    elsif self.points_awarded != new_points
      reevaluate_prediction!(new_points)
    end
  end

  def self.evaluate_all
    all.find_each(&:evaluate)
  end

  private

  # Calculate the points based on current match and prediction data
  def calculate_points
    actual_home   = match.home_goals.to_i
    actual_away   = match.away_goals.to_i
    predicted_home = home_score.to_i
    predicted_away = away_score.to_i

    if predicted_home == actual_home && predicted_away == actual_away
      3
    elsif outcome_correct?(predicted_home, predicted_away, actual_home, actual_away)
      1
    else
      0
    end
  end

  # Re-Adjusting the points and update the user's league scores accordingly.
  def reevaluate_prediction!(new_points)
    difference = new_points - self.points_awarded
    user.league_memberships.each do |membership|
      membership.increment!(:points, difference)
    end
    self.points_awarded = new_points
    save!
  end

  def outcome_correct?(predicted_home, predicted_away, actual_home, actual_away)
    predicted_outcome = outcome(predicted_home, predicted_away)
    actual_outcome = outcome(actual_home, actual_away)
    predicted_outcome == actual_outcome
  end

  def outcome(home, away)
    return :draw if home == away
    home > away ? :home : :away
  end

  def set_default_season
    self.season ||= ::Season.current
  end
end
