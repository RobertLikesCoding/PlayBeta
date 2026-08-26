class CreateJoinTableGameTesterPlatform < ActiveRecord::Migration[8.1]
  def change
    create_join_table :game_testers, :platforms do |t|
      t.index [ :game_tester_id, :platform_id ]
      t.index [ :platform_id, :game_tester_id ]
    end
  end
end
