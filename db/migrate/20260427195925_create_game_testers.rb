class CreateGameTesters < ActiveRecord::Migration[8.1]
  def change
    create_table :game_testers do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :age
      t.integer :gender

      t.timestamps
    end
  end
end
