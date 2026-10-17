class CreateInvitations < ActiveRecord::Migration[8.1]
  def change
    create_enum :invitation_status, %w[pending accepted declined]

    create_table :invitations do |t|
      t.references :game_tester, null: false, foreign_key: true
      t.references :submission, null: false, foreign_key: true
      t.enum :status, enum_type: :invitation_status, default: 'pending', null: false
      t.timestamps
    end

    add_index :invitations, [ :game_tester_id, :submission_id ], unique: true
  end
end
