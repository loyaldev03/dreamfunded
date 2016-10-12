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

ActiveRecord::Schema.define(version: 20161012030845) do

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

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

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

  create_table "campaign_events", force: true do |t|
    t.string   "state"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaign_events", ["campaign_id"], name: "index_campaign_events_on_campaign_id", using: :btree

  create_table "campaigns", force: true do |t|
    t.integer "company_id"
    t.integer "funding_goal"
    t.text    "tagline"
    t.string  "category"
    t.text    "elevator_pitch"
    t.text    "tags"
    t.text    "about_campaign"
    t.integer "employees_numer"
    t.string  "legal_company_name"
    t.string  "employer_id_number"
    t.string  "state_where_incorporated"
    t.string  "office_location"
    t.date    "date_formed"
    t.string  "company_location_address"
    t.string  "company_location_city"
    t.string  "company_location_state"
    t.string  "company_location_zipcode"
    t.string  "company_contact_info_name"
    t.string  "company_contact_info_email"
    t.string  "company_contact_info_phone"
    t.string  "legal_contact_info_name"
    t.string  "legal_contact_info_email"
    t.string  "legal_contact_info_phone"
    t.string  "legal_contact_info_firm"
    t.string  "legal_contact_info_website"
    t.string  "accounting_info_name"
    t.string  "accounting_info_email"
    t.string  "accounting_info_phone"
    t.string  "accounting_info_firm"
    t.string  "accounting_info_website"
    t.string  "state_filing_number"
    t.text    "offering_terms"
    t.text    "financial_risks"
    t.integer "totat_income"
    t.integer "total_taxable_income"
    t.integer "total_taxes_paid"
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

  create_table "co_founders", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comment_id"
    t.boolean  "reply"
    t.string   "ancestry"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree

  create_table "companies", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.integer  "invested_amount",        default: 0
    t.string   "website_link"
    t.string   "video_link",             default: ""
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
    t.date     "end_date"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "slug"
    t.text     "fund_america_code",      default: ""
    t.integer  "min_investment",         default: 100
  end

  add_index "companies", ["slug"], name: "index_companies_on_slug", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

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

  create_table "docusigns", force: true do |t|
    t.string  "envelope_id"
    t.integer "user_id"
    t.integer "company_id"
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

  create_table "financial_details", force: true do |t|
    t.text     "offering_terms"
    t.text     "fin_risks"
    t.text     "income"
    t.integer  "totat_income"
    t.integer  "total_taxable_income"
    t.integer  "total_taxes_paid"
    t.integer  "total_assets_this_year"
    t.integer  "total_assets_last_year"
    t.integer  "cash_this_year"
    t.integer  "cash_last_year"
    t.integer  "acount_receivable_this_year"
    t.integer  "acount_receivable_last_year"
    t.integer  "short_term_debt_this_year"
    t.integer  "short_term_debt_last_year"
    t.integer  "long_term_debt_this_year"
    t.integer  "long_term_debt_last_year"
    t.integer  "sales_this_year"
    t.integer  "sales_last_year"
    t.integer  "costs_of_goods_this_year"
    t.integer  "costs_of_goods_last_year"
    t.integer  "taxes_paid_this_year"
    t.integer  "taxes_paid_last_year"
    t.integer  "net_income_this_year"
    t.integer  "net_income_last_year"
    t.integer  "company_id"
    t.string   "balance_sheet_file_name"
    t.string   "balance_sheet_content_type"
    t.integer  "balance_sheet_file_size"
    t.datetime "balance_sheet_updated_at"
    t.string   "income_statements_file_name"
    t.string   "income_statements_content_type"
    t.integer  "income_statements_file_size"
    t.datetime "income_statements_updated_at"
    t.string   "statement_of_cash_flow_file_name"
    t.string   "statement_of_cash_flow_content_type"
    t.integer  "statement_of_cash_flow_file_size"
    t.datetime "statement_of_cash_flow_updated_at"
    t.string   "statement_changes_of_equity_file_name"
    t.string   "statement_changes_of_equity_content_type"
    t.integer  "statement_changes_of_equity_file_size"
    t.datetime "statement_changes_of_equity_updated_at"
    t.string   "business_plan_file_name"
    t.string   "business_plan_content_type"
    t.integer  "business_plan_file_size"
    t.datetime "business_plan_updated_at"
    t.string   "party_transaction_file_name"
    t.string   "party_transaction_content_type"
    t.integer  "party_transaction_file_size"
    t.datetime "party_transaction_updated_at"
    t.string   "intended_use_of_proceeds_file_name"
    t.string   "intended_use_of_proceeds_content_type"
    t.integer  "intended_use_of_proceeds_file_size"
    t.datetime "intended_use_of_proceeds_updated_at"
    t.string   "capital_structure_file_name"
    t.string   "capital_structure_content_type"
    t.integer  "capital_structure_file_size"
    t.datetime "capital_structure_updated_at"
    t.string   "material_terms_file_name"
    t.string   "material_terms_content_type"
    t.integer  "material_terms_file_size"
    t.datetime "material_terms_updated_at"
    t.string   "financial_conditions_file_name"
    t.string   "financial_conditions_content_type"
    t.integer  "financial_conditions_file_size"
    t.datetime "financial_conditions_updated_at"
    t.string   "directors_background_file_name"
    t.string   "directors_background_content_type"
    t.integer  "directors_background_file_size"
    t.datetime "directors_background_updated_at"
    t.string   "accountant_review_file_name"
    t.string   "accountant_review_content_type"
    t.integer  "accountant_review_file_size"
    t.datetime "accountant_review_updated_at"
    t.integer  "general_info_id"
    t.decimal  "sustain_amount"
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

  create_table "fundraise_tiers", force: true do |t|
    t.string   "amount"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "general_info_id"
  end

  create_table "general_infos", force: true do |t|
    t.string   "name"
    t.string   "kind"
    t.string   "state"
    t.date     "date_formed"
    t.integer  "employees_numer"
    t.string   "company_location_address"
    t.string   "company_location_state"
    t.string   "company_location_zipcode"
    t.string   "website"
    t.string   "employer_id_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_location_city"
    t.string   "cap_table_file_name"
    t.string   "cap_table_content_type"
    t.integer  "cap_table_file_size"
    t.datetime "cap_table_updated_at"
    t.string   "last_year_financials_file_name"
    t.string   "last_year_financials_content_type"
    t.integer  "last_year_financials_file_size"
    t.datetime "last_year_financials_updated_at"
    t.string   "last_2years_financials_file_name"
    t.string   "last_2years_financials_content_type"
    t.integer  "last_2years_financials_file_size"
    t.datetime "last_2years_financials_updated_at"
    t.string   "last_year_taxes_file_name"
    t.string   "last_year_taxes_content_type"
    t.integer  "last_year_taxes_file_size"
    t.datetime "last_year_taxes_updated_at"
    t.string   "cpa_review_file_name"
    t.string   "cpa_review_content_type"
    t.integer  "cpa_review_file_size"
    t.datetime "cpa_review_updated_at"
    t.text     "outstanding_loan"
    t.text     "financial_condition"
    t.integer  "company_id"
    t.text     "business_model"
    t.text     "business_plan"
    t.text     "business_history"
    t.text     "product_description"
    t.text     "competition"
    t.text     "customer_base"
    t.text     "intellectual_property"
    t.text     "governmental_regulatory"
    t.text     "litigation"
    t.text     "phone"
    t.integer  "days"
    t.boolean  "completed",                           default: false
    t.string   "max_amount"
    t.string   "type_of_securtity"
    t.text     "legal_name"
    t.string   "position_title"
    t.date     "first_date"
    t.text     "prev_emp"
    t.string   "prev_title"
    t.string   "prev_dates"
    t.text     "prev_resp"
    t.text     "offering_purpose"
    t.text     "fin_condition"
  end

  create_table "guests", force: true do |t|
    t.string   "email"
    t.string   "newsletter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "company"
    t.string   "name"
  end

  create_table "investment_perks", force: true do |t|
    t.text     "content"
    t.string   "amount"
    t.integer  "general_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investments", force: true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invested_amount",  default: 0
    t.integer  "number_of_shares"
  end

  add_index "investments", ["company_id"], name: "index_investments_on_company_id", using: :btree
  add_index "investments", ["user_id"], name: "index_investments_on_user_id", using: :btree

  create_table "investors", force: true do |t|
    t.integer  "annual_income"
    t.integer  "new_worth"
    t.boolean  "us_citizen"
    t.boolean  "exempt_withholding"
    t.string   "ssn"
    t.string   "country"
    t.date     "date_of_birth"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "user_id"
    t.string   "drive_license"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "invites", force: true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted"
    t.boolean  "signedup"
    t.string   "status",     default: "Hasn't signed up yet"
    t.string   "name"
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
    t.string   "source_url"
  end

  add_index "news", ["slug"], name: "index_news_on_slug", using: :btree

  create_table "officers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "year_joined"
    t.boolean  "officers"
    t.boolean  "director"
    t.text     "position"
    t.text     "occupation"
    t.string   "main_employer"
    t.integer  "general_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "education"
  end

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
    t.string   "slug"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", using: :btree

  create_table "press_posts", force: true do |t|
    t.datetime "date"
    t.text     "name"
    t.string   "source"
    t.text     "url"
    t.text     "quote"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "principal_holders", force: true do |t|
    t.string   "name"
    t.text     "securities_held"
    t.string   "voting_power"
    t.integer  "general_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "risks", force: true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "general_info_id"
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

  create_table "securities", force: true do |t|
    t.string   "security_class"
    t.string   "amount"
    t.string   "outstanding"
    t.boolean  "voting_rights"
    t.boolean  "other_rights"
    t.integer  "general_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "securities_reserved"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["slug"], name: "index_teams_on_slug", using: :btree

  create_table "terms", force: true do |t|
    t.string   "safe_cap"
    t.string   "valuation_cap"
    t.string   "investor_threshold"
    t.boolean  "pro_rata?"
    t.string   "governing_law_state"
    t.integer  "days"
    t.string   "raised_this_round"
    t.integer  "discount"
    t.integer  "store_credit"
    t.integer  "store_discount"
    t.integer  "general_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "credit",                 default: 0
    t.integer  "invite_credit",          default: 0
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "company_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

end
