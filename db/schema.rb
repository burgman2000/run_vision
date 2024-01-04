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

ActiveRecord::Schema[7.0].define(version: 2023_12_16_025932) do
  create_table "comments", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "running_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["running_id"], name: "index_comments_on_running_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "events", charset: "utf8", force: :cascade do |t|
    t.string "event_name", null: false
    t.integer "target_distance", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.text "commit", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "runnings", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "ran_distance", null: false
    t.text "ran_location", null: false
    t.text "impression", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_runnings_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "runnings", on_update: :cascade, on_delete: :cascade
  add_foreign_key "comments", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "runnings", "users", on_update: :cascade, on_delete: :cascade
end
