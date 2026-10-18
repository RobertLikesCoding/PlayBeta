class Participation < ApplicationRecord
  belongs_to :game_tester
  belongs_to :submission

  enum :status, {
    signed_up: "signed_up",    # Tester has signed up but not yet selected
    selected: "selected",      # Tester has been randomly selected to participate
    active: "active",          # Tester has started testing
    completed: "completed",    # Tester has completed the test
    canceled: "canceled"       # Participation was canceled (e.g., tester dropped out)
  }, validate: true, default: "signed_up"

  validates :game_tester_id, uniqueness: { scope: :submission_id }
end
