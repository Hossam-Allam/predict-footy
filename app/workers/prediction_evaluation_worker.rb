class PredictionEvaluationWorker
  include Sidekiq::Worker

  def perform
    # This will run every 2 hours
    Prediction.evaluate_all
    Rails.logger.info "PredictionEvaluationWorker executed at #{Time.now}"
  end
end
