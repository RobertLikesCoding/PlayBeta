class Platform < ApplicationRecord
  PLATFORMS = %w[mac windows linux ].freeze

  has_many :game_tester_platforms
  has_many :game_testers, through: :game_tester_platforms
  has_many :submission_platforms, dependent: :destroy
  has_many :submissions, through: :submission_platforms

  validates :name, presence: true, uniqueness: true, inclusion: { in: PLATFORMS }
end
