class GameTester < ApplicationRecord
  has_secure_password
  has_many :game_tester_platforms, dependent: :destroy
  has_many :platforms, through: :game_tester_platforms

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  enum :gender,  [ :prefer_not_to_say, :male, :female, :non_binary ]
  validates :gender, presence: true
  validates :birthdate, presence: true
  validate :is_age_above_16

  def validate_current_password(current_password_params)
    unless authenticate(current_password_params)
      errors.add(:current_password, "is incorrect")
      return false
    end

    true
  end

  def is_age_above_16
    return if birthdate.blank?

    threshold_date = 16.years.ago
    errors.add(:birthdate, "must indicate an age of 16 or older") if birthdate > threshold_date
  end
end
