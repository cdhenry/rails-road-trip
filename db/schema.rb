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

ActiveRecord::Schema.define(version: 20180506173255) do

  create_table "comments", force: :cascade do |t|
    t.string   "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"

  create_table "destination_tags", force: :cascade do |t|
    t.integer  "destination_id"
    t.integer  "tag_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "destinations", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "city"
    t.string   "state"
    t.string   "street_address"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "author_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "url"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"

  create_table "road_trip_destinations", force: :cascade do |t|
    t.integer  "road_trip_id"
    t.integer  "destination_id"
    t.integer  "destination_order"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "road_trips", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "title"
    t.text     "description"
    t.integer  "total_miles"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_road_trips", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "road_trip_id"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "miles_driven",    default: 0
    t.integer  "current_trip_id"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "provider"
    t.string   "uid"
  end

end
