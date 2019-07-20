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

ActiveRecord::Schema.define(version: 2019_07_16_034709) do

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
    t.bigint "source_id"
    t.string "source_type"
    t.boolean "ignored", default: false
    t.index ["requestee_id", "requester_id"], name: "index_connection_requests_on_requestee_id_and_requester_id", unique: true
    t.index ["requestee_id"], name: "index_connection_requests_on_requestee_id"
    t.index ["requester_id", "requestee_id"], name: "index_connection_requests_on_requester_id_and_requestee_id", unique: true
    t.index ["requester_id"], name: "index_connection_requests_on_requester_id"
    t.index ["source_id"], name: "index_connection_requests_on_source_id"
  end

  create_table "connection_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_connection_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_connection_tokens_on_user_id"
  end

  create_table "connections", force: :cascade do |t|
    t.bigint "requester_id"
    t.bigint "requestee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "source_id"
    t.string "source_type"
    t.index ["requestee_id", "requester_id"], name: "index_connections_on_requestee_id_and_requester_id", unique: true
    t.index ["requestee_id"], name: "index_connections_on_requestee_id"
    t.index ["requester_id", "requestee_id"], name: "index_connections_on_requester_id_and_requestee_id", unique: true
    t.index ["requester_id"], name: "index_connections_on_requester_id"
    t.index ["source_id"], name: "index_connections_on_source_id"
  end

  create_table "genders", force: :cascade do |t|
    t.string "value"
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

  create_table "privacy_group_members", force: :cascade do |t|
    t.bigint "privacy_group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["privacy_group_id"], name: "index_privacy_group_members_on_privacy_group_id"
    t.index ["user_id"], name: "index_privacy_group_members_on_user_id"
  end

  create_table "privacy_groups", force: :cascade do |t|
    t.string "name"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_privacy_groups_on_owner_id"
  end

  create_table "privacy_presets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profile_item_categories", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "item_type", default: 0
  end

  create_table "profile_item_responses", force: :cascade do |t|
    t.string "value"
    t.bigint "profile_item_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_item_category_id"], name: "index_profile_item_responses_on_profile_item_category_id"
  end

  create_table "profile_items", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "privacy_setting_id"
    t.bigint "profile_item_category_id"
    t.string "profile_item_data_type"
    t.bigint "profile_item_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "privacy_setting_type", default: "PrivacyGroup"
    t.index ["privacy_setting_id"], name: "index_profile_items_on_privacy_setting_id"
    t.index ["profile_item_category_id"], name: "index_profile_items_on_profile_item_category_id"
    t.index ["profile_item_data_type", "profile_item_data_id"], name: "profile_item_data_id"
    t.index ["user_id"], name: "index_profile_items_on_user_id"
  end

  create_table "seekings", force: :cascade do |t|
    t.bigint "gender_id"
    t.bigint "match_person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gender_id"], name: "index_seekings_on_gender_id"
    t.index ["match_person_id"], name: "index_seekings_on_match_person_id"
  end

  create_table "text_profile_items", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "gender"
    t.string "relationship_style"
    t.string "current_relationships"
    t.text "bio"
    t.integer "age"
    t.string "facebook_token"
    t.bigint "default_privacy_setting_id"
    t.string "default_privacy_setting_type", default: "PrivacyPreset"
    t.index ["default_privacy_setting_id"], name: "index_users_on_default_privacy_setting_id"
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
  add_foreign_key "privacy_group_members", "privacy_groups"
  add_foreign_key "privacy_group_members", "users"
  add_foreign_key "privacy_groups", "users", column: "owner_id"
  add_foreign_key "profile_item_responses", "profile_item_categories"
  add_foreign_key "profile_items", "profile_item_categories"
  add_foreign_key "profile_items", "users"
  add_foreign_key "seekings", "genders"
  add_foreign_key "seekings", "match_people"
end
