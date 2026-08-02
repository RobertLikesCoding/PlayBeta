class Genre < ApplicationRecord
  GENRES = %w[action adventure rpg simulation strategy sports puzzle horror platformer shooter fighting racing sandbox].freeze

  has_many :submission_genres
  has_many :submissions, through: :submission_genres

  validates :name, presence: true, uniqueness: true, inclusion: { in: GENRES }
end
