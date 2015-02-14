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

ActiveRecord::Schema.define(version: 20150214041750) do

  create_table "choices", force: true do |t|
    t.integer  "question_id",                         null: false
    t.string   "sentence",            default: "",    null: false
    t.boolean  "correct_flag",        default: false, null: false
    t.integer  "choice_number",                       null: false
    t.integer  "answered_times",                      null: false
    t.string   "image_url"
    t.string   "thumbnail_image_url"
    t.boolean  "is_delete",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "name",         default: "", null: false
    t.integer  "max_answerer",              null: false
    t.integer  "max_question",              null: false
    t.integer  "price",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "admin_user_id",                 null: false
    t.string   "name",          default: "",    null: false
    t.datetime "event_date",                    null: false
    t.datetime "limit_date",                    null: false
    t.integer  "time_limit",    default: 60,    null: false
    t.string   "url",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_delete",     default: false, null: false
  end

  create_table "question_types", force: true do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.integer  "event_id",                        null: false
    t.integer  "question_number", default: 1,     null: false
    t.string   "sentence",        default: "",    null: false
    t.integer  "points",          default: 1,     null: false
    t.integer  "type_id",                         null: false
    t.boolean  "is_delete",       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
