FactoryBot.define do
  factory :submission do
    title { Faker::Game.title }
    description { Faker::Lorem.sentence }
    genre { [ Submission::GENRES.sample ] }
    platforms { [ Faker::Game.platform ] }
    demo_url { Faker::Internet.url(host: 'example.com', scheme: 'https') }
    status { Submission::STATUS.sample }
    version { Faker::App.semantic_version }
    association :game_developer
  end
end
