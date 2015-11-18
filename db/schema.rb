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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notifiers", force: :cascade do |t|
    t.string "application",       limit: 256
    t.string "event_name",        limit: 256
    t.text   "template"
    t.json   "rules",                         default: []
    t.string "notification_type", limit: 20
    t.string "target",            limit: 256
  end

  add_index "notifiers", ["application", "event_name"], name: "index_application_event_name", using: :btree

end
