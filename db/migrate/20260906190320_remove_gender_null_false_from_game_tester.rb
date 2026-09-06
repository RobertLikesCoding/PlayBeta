class RemoveGenderNullFalseFromGameTester < ActiveRecord::Migration[8.1]
  def change
    change_column_null :game_testers, :gender, true
  end
end
