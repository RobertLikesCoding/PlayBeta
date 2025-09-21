FactoryBot.define do
  factory :submission do
    title { Faker::Game.title }
    description { Faker::Lorem.sentence }
    genre { %w[Action Adventure RPG Simulation Strategy Sports Puzzle Horror Platformer Shooter Fighting Racing Sandbox].sample }
    platforms { Faker::Game.platform }
    demo_url { Faker::Internet.url(host: 'example.com', scheme: 'https') }
    status { %w[pending approved rejected].sample }
    version { Faker::App.semantic_version }
    association :game_developer
  end
end
