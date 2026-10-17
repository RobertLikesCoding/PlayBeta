class Invitation < ApplicationRecord
  belongs_to :game_tester
  belongs_to :submission

  enum :status, {
    pending: "pending",
    accepted: "accepted",
    declined: "declined"
  }, validate: true, default: "pending"

  validates :game_tester_id, uniqueness: { scope: :submission_id }
end
