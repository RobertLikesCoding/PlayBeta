class AddIndexToTesterPlatforms < ActiveRecord::Migration[8.1]
  def change
    remove_index :game_tester_platforms, [ :game_tester_id, :platform_id ]
    add_index :game_tester_platforms, [ :game_tester_id, :platform_id ], unique: true
  end
end
