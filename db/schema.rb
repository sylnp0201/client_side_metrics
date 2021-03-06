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

ActiveRecord::Schema.define(version: 20131130054547) do

  create_table "test_meta_data", force: true do |t|
    t.string   "test_id"
    t.string   "summary"
    t.string   "test_url"
    t.string   "page"
    t.string   "location"
    t.string   "browser"
    t.string   "connectivity"
    t.datetime "ran_at"
    t.integer  "runs"
    t.integer  "first_view_id"
    t.integer  "repeat_view_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "test_meta_data", ["page", "ran_at", "location", "browser"], name: "by_page_ran_at_location_browser"

  create_table "test_view_data", force: true do |t|
    t.integer  "load_time"
    t.integer  "first_byte"
    t.integer  "start_render"
    t.integer  "bytes_in"
    t.integer  "bytes_in_doc"
    t.integer  "requests"
    t.integer  "requests_doc"
    t.integer  "fully_loaded"
    t.integer  "doc_time"
    t.integer  "dom_elements"
    t.integer  "title_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wpt_tests", force: true do |t|
    t.string   "test_id"
    t.text     "xml"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wpt_tests", ["test_id"], name: "index_wpt_tests_on_test_id", unique: true

end
