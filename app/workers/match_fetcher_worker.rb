class MatchFetcherWorker
  include Sidekiq::Worker

  def perform
    MatchFetcher.new.fetch_matches
  end
end