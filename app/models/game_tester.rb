class GameTester < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :platforms
  enum :gender, { prefer_not_to_say: 0, male: 1, female: 2, non_binary: 3 }

  validates :age, presence: true, inclusion: { in: 16..100, message: "must be between 16 and 100" }
end
