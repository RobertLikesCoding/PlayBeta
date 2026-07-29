class Genre < ApplicationRecord
  VALID_GENRES = %w[action adventure rpg simulation strategy sports puzzle horror platformer shooter fighting racing sandbox].freeze

  has_and_belongs_to_many :submissions
  validates :name, presence: true, uniqueness: true, inclusion: { in: VALID_GENRES }
end
