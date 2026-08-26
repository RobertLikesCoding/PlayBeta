class AddForeignKeysToGameTesterPlatforms < ActiveRecord::Migration[8.1]
  def change
    add_foreign_key :game_tester_platforms, :game_testers
    add_foreign_key :game_tester_platforms, :platforms
  end
end
