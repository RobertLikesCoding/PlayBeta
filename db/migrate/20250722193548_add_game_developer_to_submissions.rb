class AddGameDeveloperToSubmissions < ActiveRecord::Migration[8.0]
  def change
    add_reference :submissions, :game_developer, null: false, foreign_key: true
  end
end
