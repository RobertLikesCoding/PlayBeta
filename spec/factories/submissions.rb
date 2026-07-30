FactoryBot.define do
  factory :submission do
    title { Faker::Game.title }
    description { Faker::Lorem.sentence }
    demo_url { Faker::Internet.url(host: "example.com", scheme: "https") }
    version { Faker::App.semantic_version }
    association :game_developer

    # add genres after submission is created for association to work
    after(:create) do |submission|
      submission.genres = Genre.all.sample(2)
      submission.platforms = create_list(:platform, 2)
    end
  end
end
