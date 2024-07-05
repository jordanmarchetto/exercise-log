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

ActiveRecord::Schema[7.1].define(version: 2024_07_05_162457) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "icon"
    t.text "set_types", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "show_on_records"
  end

  create_table "workout_sets", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.string "type"
    t.integer "rep_count"
    t.integer "rep_value"
    t.integer "rpe"
    t.integer "distance"
    t.string "distance_unit"
    t.float "duration"
    t.boolean "timer_direction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "duration_unit"
    t.jsonb "data", default: {}
    t.index ["exercise_id"], name: "index_workout_sets_on_exercise_id"
  end

  add_foreign_key "workout_sets", "exercises"
end
