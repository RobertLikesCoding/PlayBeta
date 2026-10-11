class GameTesterGenre < ApplicationRecord
  belongs_to :game_tester
  belongs_to :genre

  validates :genre_id, uniqueness: { scope: :game_tester_id }
end
