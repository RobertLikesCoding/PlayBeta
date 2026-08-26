class CreateSubmissionGenres < ActiveRecord::Migration[8.1]
  def change
    create_table :submission_genres do |t|
      t.references :submission, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
