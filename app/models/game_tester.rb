class GameTester < ApplicationRecord
  has_secure_password
  has_many :game_tester_platforms, dependent: :destroy
  has_many :platforms, through: :game_tester_platforms

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 8 }, on: :create
  enum :gender, { prefer_not_to_say: 0, male: 1, female: 2, non_binary: 3 }
  validates :gender, presence: true
  validates :age, presence: true, inclusion: { in: 16..100, message: "must be between 16 and 100" }

  def validate_current_password(current_password_params)
    unless authenticate(current_password_params)
      errors.add(:current_password, "is incorrect")
      return false
    end

    true
  end
end
