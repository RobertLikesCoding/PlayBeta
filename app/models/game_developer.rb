class GameDeveloper < ApplicationRecord
  has_many :submissions

  has_secure_password # validates presence of password, and password_confirmation
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :bio, length: { maximum: 1000 }, allow_blank: true
  validates :password, length: { minimum: 8 }, on: :create

  def validate_current_password(current_password_params)
    unless authenticate(current_password_params)
      errors.add(:current_password, "is incorrect")
      return false
    end

    true
  end
end
