FactoryBot.define do
  factory :participation do
    association :submission
    association :game_tester
  end
end
