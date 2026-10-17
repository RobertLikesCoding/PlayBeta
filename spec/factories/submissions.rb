FactoryBot.define do
  factory :submission do
    title { Faker::Game.title }
    description { Faker::Lorem.sentence }
    demo_url { Faker::Internet.url(host: "example.com", scheme: "https") }
    version { Faker::App.semantic_version }
    association :game_developer
    genres { [ Genre.order(:id).first || association(:genre) ] }
    platforms { [ Platform.order(:id).first || association(:platform) ] }
  end
end
