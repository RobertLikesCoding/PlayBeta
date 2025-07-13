FactoryBot.define do
  factory :submission do
    title { Faker::Book.title }
    s_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    description { Faker::Lorem.paragraph }
    genre { %w[Action Adventure RPG Simulation Strategy Sports Puzzle Horror Platformer Shooter Fighting Racing Sandbox].sample }
    platforms { %w[Windows Mac Linux].sample }
    demo_url { Faker::Internet.url }
    status { %w[pending approved rejected].sample }
    version { Faker::App.semantic_version }
  end
end
