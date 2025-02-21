class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :match_id, presence: true, uniqueness: { scope: :user_id }

  def evaluate
    return unless match.status == "FINISHED"

    actual_home = match.home_goals.to_i
    actual_away = match.away_goals.to_i
    predicted_home = predicted_home_score.to_i
    predicted_away = predicted_away_score.to_i

    if predicted_home == actual_home && predicted_away == actual_away
      self.points_awarded = 3
    elsif outcome_correct?(predicted_home, predicted_away, actual_home, actual_away)
      self.points_awarded = 1
    else
      self.points_awarded = 0
    end

    save!

    user.league_memberships.each do |membership|
      membership.increment!(:points, self.points_awarded)
    end
  end

  private

  def outcome_correct?(predicted_home, predicted_away, actual_home, actual_away)
    predicted_outcome = outcome(predicted_home, predicted_away)
    actual_outcome = outcome(actual_home, actual_away)
    predicted_outcome == actual_outcome
  end

  def outcome(home, away)
    return :draw if home == away
    home > away ? :home : :away
  end
end
