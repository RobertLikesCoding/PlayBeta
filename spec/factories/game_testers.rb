FactoryBot.define do
  factory :game_tester do
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    age { 18 }
    gender { 1 }
  end
end
