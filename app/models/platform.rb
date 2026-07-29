class Platform < ApplicationRecord
  has_and_belongs_to_many :game_testers
  PLATFORMS = %w[mac windows linux ].freeze

  validates :name, presence: true, uniqueness: true, inclusion: { in: PLATFORMS }
end
