class SubmissionPlatform < ApplicationRecord
  belongs_to :submission
  belongs_to :platform
end
