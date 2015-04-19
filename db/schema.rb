# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150419033613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "technology_ticker_id"
    t.integer  "financial_services_ticker_id"
    t.integer  "telecommunications_ticker_id"
    t.integer  "energy_ticker_id"
    t.integer  "healthcare_ticker_id"
    t.integer  "flex_1_ticker_id"
    t.integer  "flex_2_ticker_id"
    t.integer  "flex_3_ticker_id"
    t.integer  "flex_4_ticker_id"
    t.decimal  "grade",                        precision: 5, scale: 2
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "match_type"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "max_entries"
    t.integer  "duration"
    t.integer  "wager_cents",      limit: 8
    t.integer  "winning_entry_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
  end

  create_table "tickers", force: :cascade do |t|
    t.string   "symbol"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "cusip"
    t.integer  "sector_id"
    t.string   "name"
    t.integer  "industry_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "entries", "matches", name: "entries_match_id_fk"
  add_foreign_key "entries", "tickers", column: "technology_ticker_id", name: "entries_tech_ticker_id_fk"
  add_foreign_key "entries", "users", name: "entries_user_id_fk"
  add_foreign_key "tickers", "sectors", name: "tickers_sector_id_fk"
end
