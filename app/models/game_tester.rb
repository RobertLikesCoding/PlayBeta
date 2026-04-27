class GameTester < ApplicationRecord
  has_secure_password
  enum :gender, { prefer_not_to_say: 0, male: 1, female: 2, non_binary: 3 }
end
