namespace :league do
  desc "Start a new season by copying memberships and resetting points"
  task start_new_season: :environment do
    current_season = ENV["CURRENT_SEASON"].to_i
    next_season    = ENV["NEXT_SEASON"].to_i

    LeagueMembership.where(season: current_season).find_each do |lm|
      LeagueMembership.create!(
        user_id: lm.user_id,
        league_id: lm.league_id,
        season: next_season,
        points: 0
      )
    end

    puts "New season #{next_season} created"
  end
end
