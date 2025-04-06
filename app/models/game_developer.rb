class GameDeveloper < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: ConstantData::VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 8 }
  validates :bio, length: { minimum: 20, maximum: 1000 }, allow_blank: true
  validates :studio_name, presence: true
end
