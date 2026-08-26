FactoryBot.define do
  factory :platform do
    name { Platform::PLATFORMS.sample }
  end
end
