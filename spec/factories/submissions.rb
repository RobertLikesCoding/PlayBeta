FactoryBot.define do
  factory :submission do
    title { Faker::Game.title }
    description { Faker::Lorem.sentence }
    genre { SUBMISSION_CONSTANTS[:genres].sample(2) }
    platforms { SUBMISSION_CONSTANTS[:platforms].sample(2) }
    demo_url { Faker::Internet.url(host: 'example.com', scheme: 'https') }
    version { Faker::App.semantic_version }
    association :game_developer
  end
end
