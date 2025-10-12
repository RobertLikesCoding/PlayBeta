FactoryBot.define do
  factory :event_log do
    # Optional association to the actor/owner
    association :game_developer
    # Polymorphic association for whatever object is logged (defaults to a GameDeveloper)
    association :loggable, factory: :game_developer
    action { "created" }
    changes_data { { ip: "127.0.0.1" } }

    trait :update do
      action { "updated" }
      changes_data { { "email" => [ Faker::Internet.email, Faker::Internet.email ] } }
    end

    trait :delete do
      action { "deleted" }
      changes_data { { reason: "user requested deletion" } }
    end
  end
end
