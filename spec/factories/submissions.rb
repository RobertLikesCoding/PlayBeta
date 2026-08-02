FactoryBot.define do
  factory :submission do
    title { Faker::Game.title }
    description { Faker::Lorem.sentence }
    demo_url { Faker::Internet.url(host: "example.com", scheme: "https") }
    version { Faker::App.semantic_version }
    association :game_developer

    # don't save before the after block, so the genres and platforms can be added
    to_create { |instance| instance.save(validate: false) }

    after(:create) do |submission|
      genres = Genre.all.sample(rand(1..3))
      platforms = Platform.all.sample(rand(1..3))
      raise "No genres/platforms found — did you seed the DB?" if genres.empty? || platforms.empty?

      submission.genres = genres
      submission.platforms = platforms
      submission.save!
    end
  end
end
