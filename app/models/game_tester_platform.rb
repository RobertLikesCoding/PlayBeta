class GameTesterPlatform < ApplicationRecord
  belongs_to :game_tester
  belongs_to :platform

  validates :platform_id, uniqueness: { scope: :game_tester_id }
end
