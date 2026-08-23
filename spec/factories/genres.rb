FactoryBot.define do
  factory :genre do
    name { Genre::GENRES.sample }
  end
end
