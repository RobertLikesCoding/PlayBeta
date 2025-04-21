class GameDeveloper < ApplicationRecord
  has_secure_password # validates presence of password, and password_confirmation
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :bio, length: { minimum: 20, maximum: 1000 }, allow_blank: true
  validates :studio_name, presence: true
end
