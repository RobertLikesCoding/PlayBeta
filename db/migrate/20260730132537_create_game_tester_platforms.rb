class CreateGameTesterPlatforms < ActiveRecord::Migration[8.1]
  def change
    create_table :game_tester_platforms do |t|
      t.references :game_tester, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
