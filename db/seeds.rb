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

# CREATE GAME DEVELOPERS WITH SUBMISSIONS
FactoryBot.create_list(:game_developer, 3)  do |dev, i|
  FactoryBot.create_list(:submission, Random.rand(5), game_developer: dev)
end

puts "created developers with submissions"

# CREATE GAME TESTERS
FactoryBot.create_list(:game_tester, 100)

puts "created game testers"
