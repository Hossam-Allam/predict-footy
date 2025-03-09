class PredictionEvaluatorWorker
  include Sidekiq::Worker

  def perform
    Prediction.evaluate_all
  end
end