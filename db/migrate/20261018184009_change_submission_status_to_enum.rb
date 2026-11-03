class ChangeSubmissionStatusToEnum < ActiveRecord::Migration[8.1]
  def change
    remove_column :submissions, :status if column_exists?(:submissions, :status)

    create_enum :submission_status, %w[prep live closed completed]

    add_column :submissions, :status, :submission_status, default: 'prep', null: false
  end
end
