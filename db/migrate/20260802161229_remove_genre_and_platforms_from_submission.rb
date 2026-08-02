class RemoveGenreAndPlatformsFromSubmission < ActiveRecord::Migration[8.1]
  def change
    remove_column :submissions, :genre, :string, array: true, default: []
    remove_column :submissions, :platforms, :string, array: true, default: []
  end
end
