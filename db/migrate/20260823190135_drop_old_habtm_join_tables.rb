class DropOldHabtmJoinTables < ActiveRecord::Migration[8.1]
  def change
    drop_table :genres_submissions do |t|
      t.bigint :genre_id, null: false
      t.bigint :submission_id, null: false
      t.index [ :genre_id, :submission_id ]
      t.index [ :submission_id, :genre_id ]
    end
    drop_table :game_testers_platforms do |t|
      t.bigint :game_tester_id, null: false
      t.bigint :platform_id, null: false
      t.index [ :game_tester_id, :platform_id ]
      t.index [ :platform_id, :game_tester_id ]
    end
  end
end
