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

ActiveRecord::Schema.define(version: 20140701210512) do

  create_table "aprhours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aprhours", ["date"], name: "index_aprhours_on_date"
  add_index "aprhours", ["user_id", "date"], name: "index_aprhours_on_user_id_and_date", unique: true
  add_index "aprhours", ["user_id"], name: "index_aprhours_on_user_id"

  create_table "aughours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aughours", ["date"], name: "index_aughours_on_date"
  add_index "aughours", ["user_id", "date"], name: "index_aughours_on_user_id_and_date", unique: true
  add_index "aughours", ["user_id"], name: "index_aughours_on_user_id"

  create_table "dechours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dechours", ["date"], name: "index_dechours_on_date"
  add_index "dechours", ["user_id", "date"], name: "index_dechours_on_user_id_and_date", unique: true
  add_index "dechours", ["user_id"], name: "index_dechours_on_user_id"

  create_table "febhours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "febhours", ["date"], name: "index_febhours_on_date"
  add_index "febhours", ["user_id", "date"], name: "index_febhours_on_user_id_and_date", unique: true
  add_index "febhours", ["user_id"], name: "index_febhours_on_user_id"

  create_table "hours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "janhours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "janhours", ["date"], name: "index_janhours_on_date"
  add_index "janhours", ["user_id", "date"], name: "index_janhours_on_user_id_and_date", unique: true
  add_index "janhours", ["user_id"], name: "index_janhours_on_user_id"

  create_table "julhours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "julhours", ["date"], name: "index_julhours_on_date"
  add_index "julhours", ["user_id", "date"], name: "index_julhours_on_user_id_and_date", unique: true
  add_index "julhours", ["user_id"], name: "index_julhours_on_user_id"

  create_table "junhours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "junhours", ["date"], name: "index_junhours_on_date"
  add_index "junhours", ["user_id", "date"], name: "index_junhours_on_user_id_and_date", unique: true
  add_index "junhours", ["user_id"], name: "index_junhours_on_user_id"

  create_table "marhours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "marhours", ["date"], name: "index_marhours_on_date"
  add_index "marhours", ["user_id", "date"], name: "index_marhours_on_user_id_and_date", unique: true
  add_index "marhours", ["user_id"], name: "index_marhours_on_user_id"

  create_table "mayhours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mayhours", ["date"], name: "index_mayhours_on_date"
  add_index "mayhours", ["user_id", "date"], name: "index_mayhours_on_user_id_and_date", unique: true
  add_index "mayhours", ["user_id"], name: "index_mayhours_on_user_id"

  create_table "novhours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "novhours", ["date"], name: "index_novhours_on_date"
  add_index "novhours", ["user_id", "date"], name: "index_novhours_on_user_id_and_date", unique: true
  add_index "novhours", ["user_id"], name: "index_novhours_on_user_id"

  create_table "octhours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "octhours", ["date"], name: "index_octhours_on_date"
  add_index "octhours", ["user_id", "date"], name: "index_octhours_on_user_id_and_date", unique: true
  add_index "octhours", ["user_id"], name: "index_octhours_on_user_id"

  create_table "orgs", force: true do |t|
    t.string   "org_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sephours", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "numhours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sephours", ["date"], name: "index_sephours_on_date"
  add_index "sephours", ["user_id", "date"], name: "index_sephours_on_user_id_and_date", unique: true
  add_index "sephours", ["user_id"], name: "index_sephours_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "org_id"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
