class MakeAgeRequiredForGameTesters < ActiveRecord::Migration[8.1]
  def change
    change_column_null :game_testers, :age, false
  end
end
