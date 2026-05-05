class Genre < ApplicationRecord
  has_many :game_submissions

  validates :name, inclusion: { in: SUBMISSION_CONSTANTS }
end
