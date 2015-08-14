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

ActiveRecord::Schema.define(version: 20150720194555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "user_id"
    t.string   "name"
    t.string   "description"
    t.string   "image_file_name"
    t.integer  "invested_amount"
    t.string   "website_link"
    t.string   "video_link"
    t.integer  "goal_amount"
    t.integer  "status"
    t.string   "CEO"
    t.string   "CEO_number"
    t.integer  "display"
    t.integer  "days_left"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "founders", force: true do |t|
    t.string   "name"
    t.string   "position"
    t.string   "image_address"
    t.string   "content"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", force: true do |t|
    t.string   "title"
    t.string   "image_filename"
    t.text     "content"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.integer  "company_id"
    t.string   "overview"
    t.string   "target_market"
    t.string   "current_investor_details"
    t.string   "detailed_metrics"
    t.string   "customer_testimonials"
    t.string   "competitive_landscape"
    t.string   "planned_use_of_funds"
    t.string   "pitch_deck"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "teams", force: true do |t|
    t.string "name"
    t.string "file_name"
    t.string "summary"
    t.string "fullbio"
  end

  create_table "users", force: true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "login"
    t.string  "email"
    t.integer "authority"
    t.string  "salt"
    t.string  "password_digest"
  end

end
