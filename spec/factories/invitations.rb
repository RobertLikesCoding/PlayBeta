FactoryBot.define do
  factory :invitation do
    association :submission
    association :game_tester
  end
end
