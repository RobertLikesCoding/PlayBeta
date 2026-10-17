class Participation < ApplicationRecord
  belongs_to :game_tester
  belongs_to :submission

  enum :status, {
    active: "active",
    completed: "completed",
    canceled: "canceled"
  }, validate: true, default: "active"

  validates :game_tester_id, uniqueness: { scope: :submission_id }
end
