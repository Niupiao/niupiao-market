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

ActiveRecord::Schema.define(version: 20150806202855) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "city"
    t.string   "district"
    t.string   "committee"
    t.string   "street"
    t.string   "door"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "key"
    t.text     "name"
    t.string   "phone"
    t.string   "license"
    t.text     "bank_info"
    t.float    "amount_owed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "user_id"
    t.text    "name"
    t.text    "item_type"
    t.text    "tags"
    t.float   "price"
    t.integer "quantity"
    t.text    "desc"
    t.integer "subitem_id"
    t.text    "subitem_type"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "payment_type"
    t.text     "bank_account"
    t.text     "card_number"
    t.text     "cvv"
    t.text     "holder"
    t.integer  "exp_month"
    t.integer  "exp_year"
    t.text     "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "phones", force: :cascade do |t|
    t.text     "manufacturer"
    t.text     "origin"
    t.integer  "best"
    t.integer  "item_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.text     "item_name"
    t.integer  "item_quantity"
    t.text     "item_tags"
    t.text     "item_type"
    t.string   "status"
    t.text     "checkin_code"
    t.text     "seller_availability"
    t.text     "buyer_availability"
    t.integer  "claimed"
    t.text     "delivery_instruction"
    t.float    "charge"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.text     "body"
    t.integer  "rating"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "super_admins", force: :cascade do |t|
    t.string   "username"
    t.text     "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.text     "email"
    t.text     "password_digest"
    t.text     "cart"
    t.string   "phone"
    t.integer  "address_id"
    t.text     "provider"
    t.text     "uid"
    t.text     "oauth_token"
    t.text     "oauth_expires_at"
    t.integer  "email_confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
