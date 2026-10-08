class CreateGameTesterGenres < ActiveRecord::Migration[8.1]
  def change
    create_table :game_tester_genres do |t|
      t.references :game_tester, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end

    add_index :game_tester_genres, [ :game_tester_id, :genre_id ], unique: true
  end
end
