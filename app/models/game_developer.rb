class GameDeveloper < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 8 }
  validates :bio, length: { minimum: 20, maximum: 1000 }, allow_blank: true
  validates :studio_name, presence: true
end
