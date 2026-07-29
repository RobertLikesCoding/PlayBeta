class Platform < ApplicationRecord
  PLATFORMS = %w[mac windows linux ].freeze

  validates :name, presence: true, uniqueness: true, inclusion: { in: PLATFORMS }
end
