FactoryBot.define do
  factory :game_tester do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    birthdate { rand(16..40).years.ago.to_date }
    gender { rand(0..3) }
  end
end
