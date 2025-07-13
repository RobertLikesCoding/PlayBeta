class Submission < ApplicationRecord
  belongs_to :game_developer

  validates :title, presence: true, length: { maximum: 100 }
  validates :s_id, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :genre, presence: true, inclusion: { in: %w[Action Adventure RPG Simulation Strategy Sports Puzzle Horror Platformer Shooter Fighting Racing Sandbox] }
  validates :demo_url, presence: true, format: { with: /\Ahttps:\/\/.+\z/, message: "must start with https://" }
  validates :version, presence: true, length: { maximum: 20 }
end
