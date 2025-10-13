# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_12_192036) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "event_logs", force: :cascade do |t|
    t.string "loggable_type", null: false
    t.bigint "loggable_id", null: false
    t.bigint "game_developer_id"
    t.string "action", null: false
    t.jsonb "changes_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action"], name: "index_event_logs_on_action"
    t.index ["created_at"], name: "index_event_logs_on_created_at"
    t.index ["game_developer_id"], name: "index_event_logs_on_game_developer_id"
    t.index ["loggable_type", "loggable_id"], name: "index_event_logs_on_loggable"
  end

  create_table "game_developers", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "bio"
    t.string "website"
    t.string "studio_name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.string "title"
    t.uuid "s_id", default: -> { "gen_random_uuid()" }
    t.string "description"
    t.string "genre"
    t.string "platforms"
    t.string "demo_url"
    t.string "status"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_developer_id", null: false
    t.index ["game_developer_id"], name: "index_submissions_on_game_developer_id"
  end

  add_foreign_key "event_logs", "game_developers"
  add_foreign_key "submissions", "game_developers"
end
