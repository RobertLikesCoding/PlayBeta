# config/initializers/constants.rb
SUBMISSION_CONSTANTS = {
  genres: Genre.select(:id, :name).map { |g| { id: g.id, name: g.name } },
  platforms: Platform.select(:id, :name).map { |g| { id: g.id, name: g.name } }
}.freeze
