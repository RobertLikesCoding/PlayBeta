class Submission < ApplicationRecord
  include Loggable
  STATUS = %w[in_review approved rejected]

  belongs_to :game_developer
  has_many :event_logs, as: :loggable, dependent: :destroy
  before_validation :give_s_id

  validates :title, presence: true, length: { maximum: 100 }
  validates :s_id, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :genre, presence: true, inclusion: { in: SUBMISSION_CONSTANTS[:genres] }
  validates :platforms, presence: true, inclusion: { in: SUBMISSION_CONSTANTS[:platforms] }
  validates :demo_url, presence: true, format: { with: /\Ahttps:\/\/.+\z/, message: "must start with https://" }
  validates :version, presence: true, length: { maximum: 20 }
  attribute :status, :string, default: "in_review"
  validates :status, presence: true, inclusion: { in: STATUS }

  def give_s_id
    self.s_id ||= SecureRandom.uuid
  end
end
