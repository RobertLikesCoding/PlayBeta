# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create Genres and Platforms first
Genre::GENRES.each do |genre|
  Genre.find_or_create_by(name: genre)
end

puts "created Genres"

Platform::PLATFORMS.each do |platform|
  Platform.find_or_create_by(name: platform)
end

puts "created Platforms"

# CREATE DEV USER ACCOUNTS
GameTester.create!(
  email: ENV["GAME_TESTER_EMAIL"],
  password: ENV["GAME_TESTER_PASSWORD"],
  password_confirmation: ENV["GAME_TESTER_PASSWORD"],
  birthdate: Date.new(1990, 1, 1)
)
GameDeveloper.create!(
  email: ENV["GAME_DEVELOPER_EMAIL"],
  password: ENV["GAME_DEVELOPER_PASSWORD"],
  password_confirmation: ENV["GAME_DEVELOPER_PASSWORD"]
) do |dev|
  FactoryBot.create_list(:submission, 3, game_developer: dev)
end

# fill db with tester accounts
FactoryBot.create_list(:game_tester, 100)

puts "created game testers"

# CREATE GAME DEVELOPERS WITH SUBMISSIONS
FactoryBot.create_list(:game_developer, 3)  do |dev, i|
  FactoryBot.create_list(:submission, Random.rand(5), game_developer: dev)
end

puts "created developers with submissions"
