class AddBirthdateToGameTesters < ActiveRecord::Migration[8.1]
  def change
    add_column :game_testers, :birthdate, :date, null: false
    remove_column :game_testers, :age, :integer
    change_column_null :game_testers, :gender, false
  end
end
