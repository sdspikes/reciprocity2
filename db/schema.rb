# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_29_072237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "activity_id"
    t.bigint "checker_id"
    t.bigint "checked_id"
    t.index ["activity_id"], name: "index_checks_on_activity_id"
    t.index ["checked_id"], name: "index_checks_on_checked_id"
    t.index ["checker_id"], name: "index_checks_on_checker_id"
  end

  create_table "compatibilities", force: :cascade do |t|
    t.boolean "dealbreaker", default: false
    t.integer "rating"
    t.text "notes"
    t.boolean "introduction_made", default: false
    t.bigint "match_person_1_id"
    t.bigint "match_person_2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_person_1_id"], name: "index_compatibilities_on_match_person_1_id"
    t.index ["match_person_2_id"], name: "index_compatibilities_on_match_person_2_id"
  end

  create_table "connection_requests", force: :cascade do |t|
    t.bigint "requester_id"
    t.bigint "requestee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requestee_id"], name: "index_connection_requests_on_requestee_id"
    t.index ["requester_id"], name: "index_connection_requests_on_requester_id"
  end

  create_table "connections", force: :cascade do |t|
    t.bigint "requester_id"
    t.bigint "requestee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requestee_id"], name: "index_connections_on_requestee_id"
    t.index ["requester_id"], name: "index_connections_on_requester_id"
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_people", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "okc"
    t.string "fb"
    t.string "li"
    t.integer "age"
    t.string "acceptable_range"
    t.string "occupation"
    t.string "location"
    t.bigint "gender_id"
    t.integer "openness"
    t.string "identities"
    t.text "current_partners"
    t.text "situation"
    t.text "kids"
    t.binary "ask_first"
    t.string "keep_dating"
    t.binary "only_strong_match"
    t.string "num_matches"
    t.text "important"
    t.text "disappointments"
    t.text "date_activities"
    t.text "murphyjitsu"
    t.text "incompatible"
    t.binary "continue_matching"
    t.text "anything_else"
    t.text "notes"
    t.string "image_link"
    t.string "seeking_genders"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_age", default: 100
    t.integer "min_age", default: 18
    t.index ["gender_id"], name: "index_match_people_on_gender_id"
  end

  create_table "seekings", force: :cascade do |t|
    t.bigint "gender_id"
    t.bigint "match_person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gender_id"], name: "index_seekings_on_gender_id"
    t.index ["match_person_id"], name: "index_seekings_on_match_person_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.text "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "checks", "activities"
  add_foreign_key "checks", "users", column: "checked_id"
  add_foreign_key "checks", "users", column: "checker_id"
  add_foreign_key "connection_requests", "users", column: "requestee_id"
  add_foreign_key "connection_requests", "users", column: "requester_id"
  add_foreign_key "connections", "users", column: "requestee_id"
  add_foreign_key "connections", "users", column: "requester_id"
  add_foreign_key "match_people", "genders"
  add_foreign_key "seekings", "genders"
  add_foreign_key "seekings", "match_people"
end
