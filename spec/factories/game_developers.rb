FactoryBot.define do
  factory :game_developer do
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    studio_name { "Awesome Studio" }
    bio { "This is a short bio about the game developer. They are awesome!" }

    # Define traits for specific scenarios
    trait :invalid do
      email { "" }
      password { "" }
      studio_name { "" }
    end

    trait :long_bio do
      bio { "A" * 1002 }
    end
  end
end
