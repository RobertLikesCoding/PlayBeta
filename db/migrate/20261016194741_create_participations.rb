class CreateParticipations < ActiveRecord::Migration[8.1]
  def change
    create_enum :participation_status, %w[active completed canceled]

    create_table :participations do |t|
      t.references :game_tester, null: false, foreign_key: true
      t.references :submission, null: false, foreign_key: true
      t.enum :status, enum_type: :participation_status, default: 'active', null: false
      t.timestamps
    end

    add_index :participations, [ :game_tester_id, :submission_id ], unique: true
  end
end
