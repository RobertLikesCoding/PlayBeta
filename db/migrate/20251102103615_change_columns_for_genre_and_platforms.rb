class ChangeColumnsForGenreAndPlatforms < ActiveRecord::Migration[7.1]
  def change
    remove_column :submissions, :genre
    remove_column :submissions, :platforms

    add_column :submissions, :genre, :string, array: true, default: []
    add_column :submissions, :platforms, :string, array: true, default: []
  end
end
