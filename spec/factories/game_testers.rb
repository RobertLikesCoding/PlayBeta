FactoryBot.define do
  factory :game_tester do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    birthdate { rand(16..40).years.ago.to_date }
    gender { [ :prefer_not_to_say, :male, :female, :non_binary ].sample }
    genres do
      Genre.order(:id).to_a.sample(5).presence || [ association(:genre) ]
    end
    platforms do
      Platform.order(:id).to_a.sample(5).presence || [ association(:platform) ]
    end
  end
end
