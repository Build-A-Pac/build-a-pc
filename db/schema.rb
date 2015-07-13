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

ActiveRecord::Schema.define(version: 20150707190259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "build_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "cpu_weight"
    t.integer  "gpu_weight"
    t.integer  "psu_weight"
    t.integer  "ram_weight"
    t.integer  "storage_weight"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "computer_parts", force: :cascade do |t|
    t.integer  "computer_id"
    t.integer  "part_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "computers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "computer_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "parts", force: :cascade do |t|
    t.string   "name"
    t.string   "make"
    t.string   "model"
    t.string   "category"
    t.float    "cost"
    t.string   "store_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "full_name"
    t.string   "email"
    t.string   "password"
    t.boolean  "admin",      default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
