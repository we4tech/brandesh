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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120423051553) do

  create_table "agencies", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "street"
    t.string   "area"
    t.string   "city"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "agency_id"
    t.string   "ad_title"
    t.string   "ad_headline"
    t.text     "ad_description"
    t.text     "ad_short_rationale"
    t.text     "ad_consumer_insight"
    t.string   "brand"
    t.string   "brand_manager"
    t.text     "brand_details"
    t.string   "account_manager"
    t.string   "creative_directory"
    t.string   "art_director"
    t.string   "copyright"
    t.string   "illustrator"
    t.string   "photographer"
    t.string   "digital_producer"
    t.string   "creative_developer"
    t.string   "creative_strategy"
    t.string   "sound_director"
    t.text     "additional_credits"
    t.string   "media_type"
    t.date     "published_on"
    t.string   "category"
    t.string   "media_filename"
    t.string   "proof_filename"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "designation"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
