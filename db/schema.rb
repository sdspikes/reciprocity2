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

ActiveRecord::Schema.define(version: 2018_06_12_192109) do

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
end
