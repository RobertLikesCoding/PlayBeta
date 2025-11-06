class Submission < ApplicationRecord
  include Loggable
  STATUS = %w[in_review approved rejected]

  belongs_to :game_developer
  has_many :event_logs, as: :loggable, dependent: :destroy
  before_validation :give_s_id

  validates :title, presence: true, length: { maximum: 100 }
  validates :s_id, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :genre, presence: true
  validate :genres_must_be_valid
  validates :platforms, presence: true
  validate :platforms_must_be_valid
  validates :demo_url, presence: true, format: { with: /\Ahttps:\/\/.+\z/, message: "must start with https://" }
  validates :version, presence: true, length: { maximum: 20 }
  attribute :status, :string, default: "in_review"
  validates :status, presence: true, inclusion: { in: STATUS }

  def give_s_id
    self.s_id ||= SecureRandom.uuid
  end

  def platforms_must_be_valid
    return if platforms.blank?

    invalid = platforms - SUBMISSION_CONSTANTS[:platforms]
    if invalid.any?
      errors.add(:platforms, "contains invalid values: #{invalid.join(', ')}")
    end
  end

  def genres_must_be_valid
    return if genre.blank?

    invalid = genre - SUBMISSION_CONSTANTS[:genres]
    if invalid.any?
      errors.add(:genre, "contains invalid values: #{invalid.join(', ')}")
    end
  end
end
