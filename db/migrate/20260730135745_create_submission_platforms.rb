class CreateSubmissionPlatforms < ActiveRecord::Migration[8.1]
  def change
    create_table :submission_platforms do |t|
      t.references :submission, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
