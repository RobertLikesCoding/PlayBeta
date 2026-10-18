class Submission < ApplicationRecord
  include Loggable

  enum :status, {
    prep: "prep",
    active: "active",
    closed: "closed",
    completed: "completed"
  }, validate: true, default: "prep"

  belongs_to :game_developer
  has_many :event_logs, as: :loggable, dependent: :destroy
  has_many :submission_genres, dependent: :destroy
  has_many :genres, through: :submission_genres
  has_many :submission_platforms, dependent: :destroy
  has_many :platforms, through: :submission_platforms
  has_many :participations, dependent: :destroy
  has_many :game_testers, through: :participations

  before_validation :give_s_id
  validates :title, presence: true, length: { maximum: 100 }
  validates :s_id, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :genres, presence: true
  validates :platforms, presence: true
  validates :demo_url, presence: true, format: { with: /\Ahttps:\/\/.+\z/, message: "must start with https://" }
  validates :version, presence: true

  def give_s_id
    self.s_id ||= SecureRandom.uuid
  end
end
