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

ActiveRecord::Schema.define(:version => 20120507190711) do

  create_table "addresses", :force => true do |t|
    t.string   "address"
    t.spatial  "latlon",     :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "index"
    t.string   "create"
    t.string   "destroy"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "counties", :force => true do |t|
    t.string   "name"
    t.spatial  "geometry",   :limit => {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.datetime "created_at",                                                                :null => false
    t.datetime "updated_at",                                                                :null => false
  end

  create_table "fire_stations", :force => true do |t|
    t.string   "address"
    t.spatial  "latlon",     :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.integer  "zip"
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "phone"
    t.boolean  "preferred_contact"
    t.string   "provider"
    t.string   "twitter_screen_name"
    t.string   "twitter_display_name"
    t.string   "provider_id"
    t.string   "referral_code"
    t.string   "share_code"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
