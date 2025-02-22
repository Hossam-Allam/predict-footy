# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# config/schedule.rb
set :output, "log/cron.log"
set :environment, ENV["RAILS_ENV"] || "development"

# Define the custom job type FIRST
job_type :rbenv_runner, %Q{
  eval "$(rbenv init -)";
  cd :path && RAILS_ENV=:environment bundle exec rails runner ":task" :output
}

# Then use the custom job type for your tasks
every 5.minutes do
  rbenv_runner "MatchFetcher.new.fetch_matches"  # Changed from 'runner' to 'rbenv_runner'
end

every 2.hours do
  rbenv_runner "Prediction.evaluate_all"  # Changed from 'runner' to 'rbenv_runner'
end
