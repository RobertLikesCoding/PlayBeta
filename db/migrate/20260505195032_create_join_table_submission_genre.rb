class CreateJoinTableSubmissionGenre < ActiveRecord::Migration[8.1]
  def change
    create_join_table :submissions, :genres do |t|
      t.index [ :submission_id, :genre_id ]
      t.index [ :genre_id, :submission_id ]
    end
  end
end
