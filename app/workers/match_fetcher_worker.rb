class MatchFetcherWorker
  include Sidekiq::Worker

  def perform
    # This will run every 30 minutes
    MatchFetcher.new.fetch_matches
    Rails.logger.info "MatchFetcherWorker executed at #{Time.now}"
  end
end
