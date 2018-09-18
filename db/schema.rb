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

ActiveRecord::Schema.define(version: 20180823024059) do

  create_table "comments", force: :cascade do |t|
    t.string   "writer"
    t.integer  "post_id"
    t.text     "content",    default: ""
    t.float    "star_score", default: 0.0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "follows", force: :cascade do |t|
    t.string   "following_id"
    t.string   "follower_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "sender_id"
    t.string   "receiver_id"
    t.string   "message"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.string   "writer",                                null: false
    t.integer  "total_price",    default: 0
    t.integer  "people_num",     default: 0
    t.text     "content",        default: ""
    t.string   "category"
    t.float    "avg_star_score", default: 0.0
    t.float    "lat"
    t.float    "lng"
    t.date     "final_date",     default: '2018-08-23'
    t.integer  "total_star",     default: 0
    t.integer  "comment_cnt",    default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "food_photo"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "name",                   default: ""
    t.string   "birthdate",              default: ""
    t.string   "email_confirm"
    t.string   "gender"
    t.string   "phone",                  default: ""
    t.string   "introduce",              default: ""
    t.float    "star_score",             default: 0.0
    t.float    "latitude",               default: 0.0
    t.float    "longitude",              default: 0.0
    t.string   "back_photo_addr"
    t.string   "profile_photo_addr"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
