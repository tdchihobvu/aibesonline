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

ActiveRecord::Schema.define(:version => 20140222144849) do

  create_table "comments", :force => true do |t|
    t.string   "username"
    t.text     "message"
    t.boolean  "publish",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "customer_orders", :force => true do |t|
    t.string   "order_no"
    t.string   "customer_name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "mobile_no"
    t.string   "email"
    t.integer  "payment_gateway_id"
    t.boolean  "delivery",           :default => false
    t.boolean  "paid",               :default => false
    t.boolean  "processed",          :default => false
    t.boolean  "collected",          :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "trans_code"
    t.date     "posted_on"
  end

  create_table "global_settings", :force => true do |t|
    t.string "config_key"
    t.string "config_value"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "product_id",                                                           :null => false
    t.integer  "customer_order_id",                                                    :null => false
    t.integer  "quantity",                                                             :null => false
    t.decimal  "total_price",          :precision => 8,  :scale => 2, :default => 0.0, :null => false
    t.string   "ipaddress"
    t.string   "location"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.decimal  "total_delivery_price", :precision => 10, :scale => 0
  end

  create_table "payment_gateways", :force => true do |t|
    t.string   "name"
    t.string   "provider"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "product_brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "product_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "product_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "code",                                              :default => "",    :null => false
    t.string   "name",                                              :default => "",    :null => false
    t.string   "release_year"
    t.string   "name_prefix"
    t.decimal  "price",               :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.decimal  "unit_vat",            :precision => 8, :scale => 2, :default => 0.0
    t.text     "description"
    t.integer  "quantity",                                                             :null => false
    t.integer  "product_type_id",                                                      :null => false
    t.integer  "product_category_id",                                                  :null => false
    t.integer  "product_brand_id",                                                     :null => false
    t.integer  "sales"
    t.integer  "views"
    t.integer  "promotion_days"
    t.boolean  "on_promotion",                                      :default => false
    t.boolean  "featured",                                          :default => false
    t.boolean  "top_10",                                            :default => false
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.string   "image_url"
    t.decimal  "delivery_price",      :precision => 8, :scale => 2, :default => 0.0
    t.boolean  "special_available",                                 :default => false
    t.boolean  "upcoming",                                          :default => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "user_requests", :force => true do |t|
    t.string   "username"
    t.text     "message"
    t.boolean  "publish",    :default => false
    t.boolean  "notify_me",  :default => false
    t.string   "mobile_no"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "email"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "random_pass"
    t.boolean  "is_active",              :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "salt"
    t.string   "email"
    t.boolean  "registered",             :default => false
    t.boolean  "manager",                :default => false
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

end
