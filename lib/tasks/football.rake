namespace :football do
  desc "Fetch Premier League matches from football-data.org"
  task fetch_matches: :environment do
    MatchFetcher.new.fetch_matches
    puts "Matches fetched successfully!"
  end
end
