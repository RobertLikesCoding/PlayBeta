FactoryBot.define do
  factory :game_tester do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    age { rand(16..100) }
    gender { rand(0..3) }
  end
end
