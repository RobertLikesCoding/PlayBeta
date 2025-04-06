class CreateGameDevelopers < ActiveRecord::Migration[8.0]
  def change
    create_table :game_developers do |t|
      t.string :email
      t.string :password_digest
      t.string :bio
      t.string :website
      t.string :studio_name
      t.string :location

      t.timestamps
    end
  end
end
