require "sidekiq"
require "sidekiq-cron"


Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

if Sidekiq.server?
  Sidekiq::Cron::Job.create(
    name: 'Match Fetcher - every 15 minutes',
    cron: '*/15 * * * *',
    class: 'MatchFetcherWorker'
  )

  Sidekiq::Cron::Job.create(
    name: 'Prediction Evaluator - every 2 hours',
    cron: '0 */2 * * *',
    class: 'PredictionEvaluatorWorker'
  )
end