class RemoveVisibilityFromSubmissions < ActiveRecord::Migration[8.0]
  def change
    remove_column :submissions, :visibility
  end
end
