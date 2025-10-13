class CreateEventLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :event_logs do |t|
      t.references :loggable, polymorphic: true, null: false
      t.references :game_developer, foreign_key: true, null: true
      t.string :action, null: false
      t.jsonb :changes_data, default: {}

      t.timestamps
    end

    add_index :event_logs, :action
    add_index :event_logs, :created_at
  end
end
