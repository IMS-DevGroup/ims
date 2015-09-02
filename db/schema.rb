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

ActiveRecord::Schema.define(version: 20150902100221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "barcode_tests", force: :cascade do |t|
    t.integer  "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_types", force: :cascade do |t|
    t.string   "name"
    t.text     "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.boolean  "ready"
    t.text     "info"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lendings", force: :cascade do |t|
    t.datetime "receive"
    t.text     "lending_info"
    t.text     "receive_info"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "lender_id"
    t.integer  "receiver_id"
    t.text     "signature"
  end

  create_table "operations", force: :cascade do |t|
    t.integer  "number"
    t.string   "type"
    t.text     "info"
    t.string   "location"
    t.datetime "close_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.text     "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rights", force: :cascade do |t|
    t.boolean  "manage_rights"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_key"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "startpages", force: :cascade do |t|
    t.string   "title"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "name"
    t.text     "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks_operations", id: false, force: :cascade do |t|
    t.integer "stock_id"
    t.integer "operation_id"
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.text     "info"
    t.integer  "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.boolean  "active"
    t.string   "email"
    t.string   "prename"
    t.string   "lastname"
    t.integer  "mobile_number"
    t.text     "info"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "salt"
  end

  create_table "values", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
