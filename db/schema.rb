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

ActiveRecord::Schema.define(version: 20160412183846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "bids", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auction_id"
    t.boolean  "accepted"
    t.integer  "company_id"
    t.integer  "number_of_shares"
    t.integer  "user_id"
    t.string   "status",           default: "pending"
    t.float    "bid_amount"
    t.integer  "counter_amount",   default: 0
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "companies", force: true do |t|
    t.string   "user_id"
    t.string   "name"
    t.text     "description"
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
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.text     "docusign_url"
    t.integer  "position",               default: 0
    t.boolean  "hidden",                 default: false
    t.float    "suggested_target_price"
    t.boolean  "accredited"
  end

  create_table "documents", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.text     "description"
    t.date     "date"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "founders", force: true do |t|
    t.string   "name"
    t.string   "position"
    t.string   "image_address"
    t.text     "content"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "guests", force: true do |t|
    t.string   "email"
    t.string   "newsletter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investments", force: true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invested_amount", default: 0
  end

  add_index "investments", ["company_id"], name: "index_investments_on_company_id", using: :btree
  add_index "investments", ["user_id"], name: "index_investments_on_user_id", using: :btree

  create_table "invites", force: true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted"
    t.boolean  "signedup"
  end

  create_table "liquidate_shares", force: true do |t|
    t.string   "first_name"
    t.string   "company"
    t.integer  "number_shares"
    t.integer  "shares_price"
    t.string   "timeframe"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.string   "last_name"
    t.boolean  "rofr_restrictions"
    t.boolean  "financial_assistance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "suggested_target_price"
    t.boolean  "approved"
    t.integer  "user_id"
    t.integer  "company_id"
  end

  create_table "members", force: true do |t|
    t.string   "name"
    t.text     "summary"
    t.text     "fullbio"
    t.string   "title"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
  end

  add_index "members", ["slug"], name: "index_members_on_slug", using: :btree

  create_table "news", force: true do |t|
    t.text     "title"
    t.string   "image_filename"
    t.text     "content"
    t.text     "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
    t.integer  "position",           default: 0
    t.string   "video_link",         default: ""
  end

  add_index "news", ["slug"], name: "index_news_on_slug", using: :btree

  create_table "paragraphs", force: true do |t|
    t.string  "page"
    t.text    "title"
    t.text    "content"
    t.integer "position"
  end

  create_table "posts", force: true do |t|
    t.text     "content"
    t.text     "title"
    t.string   "source"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",           default: 0
    t.string   "page"
  end

  create_table "prospective_investments", force: true do |t|
    t.string   "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "company"
    t.string   "company_id"
    t.string   "investment_amount"
    t.float    "shares_price"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.integer  "company_id"
    t.text     "overview"
    t.text     "target_market"
    t.text     "current_investor_details"
    t.text     "detailed_metrics"
    t.text     "customer_testimonials"
    t.text     "competitive_landscape"
    t.text     "planned_use_of_funds"
    t.text     "pitch_deck"
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
    t.string   "name"
    t.string   "file_name"
    t.text     "summary"
    t.text     "fullbio"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title"
    t.string   "slug"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["slug"], name: "index_teams_on_slug", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "login"
    t.string   "email"
    t.integer  "authority"
    t.string   "salt"
    t.string   "password_digest"
    t.boolean  "confirmed",              default: false
    t.string   "slug"
    t.integer  "invested_amount",        default: 0
    t.string   "phone"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.integer  "credit"
  end

  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

end
