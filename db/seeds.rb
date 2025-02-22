# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
owner = User.find_or_create_by!(id: 1) do |user|
  user.name = "Default Owner"
  user.email = "owner@example.com"
  user.password = "securepassword"
end

# Create or find the league
worldwide = League.find_or_create_by!(name: "Worldwide") do |league|
  league.owner = owner
end
