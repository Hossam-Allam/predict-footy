class FetchAndEvaluateJob < ApplicationJob
  queue_as :default

  def perform
    MatchFetcher.new.fetch_matches
    Prediction.evaluate_all
  end
end
