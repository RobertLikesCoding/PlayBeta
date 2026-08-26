class SubmissionGenre < ApplicationRecord
  belongs_to :submission
  belongs_to :genre
end
