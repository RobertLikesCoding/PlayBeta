FactoryBot.define do
  factory :event_log do
    # Optional association to the actor/owner
    association :game_developer
    association :loggable, factory: :submission # defaults to submission
    action { "created" }
    changes_data { {  "title" => "New title" } }

    trait :update do
      action { "updated" }
      changes_data { { "email" => [ Faker::Internet.email, Faker::Internet.email ] } }
    end

    trait :for_submission do
      association :loggable, factory: :submission
      action { "updated" }
      changes_data {
        {
          "title" => [ "Old title", "New title" ],
          "description" => [ "Old description", "New description" ],
          "status" => [ "pending", "approved" ],
          "demo_url" => [ "https://old.example.com", "https://new.example.com" ],
          "version" => [ "0.9", "1.0" ]
        }
      }
    end

    trait :delete do
      action { "deleted" }
      changes_data { { "reason" => [ "existing value", "deleted" ] } }
    end
  end
end
