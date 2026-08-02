class GameTester < ApplicationRecord
  has_secure_password
  has_many :game_tester_platforms, dependent: :destroy
  has_many :platforms, through: :game_tester_platforms

  enum :gender, { prefer_not_to_say: 0, male: 1, female: 2, non_binary: 3 }
  validates :age, presence: true, inclusion: { in: 16..100, message: "must be between 16 and 100" }
end
