
redis_url = ENV.fetch("REDIS_URL") do
  "redis://localhost:6379/0" # fallback for development/local testing
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end
