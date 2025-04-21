FactoryBot.define do
  factory :game_developer do
    email { Faker::Internet.email }
    password { "passywordy2" }
    studio_name { Faker::Company.name }
    bio { Faker::Lorem.sentence(word_count: 30) }
  end
end
