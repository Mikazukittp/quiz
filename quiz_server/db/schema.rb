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

ActiveRecord::Schema.define(version: 20150530063354) do

  create_table "admin_users", force: true do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_delete"
    t.string   "authentication_token"
  end

  add_index "admin_users", ["confirmation_token"], name: "index_admin_users_on_confirmation_token", unique: true
  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  add_index "admin_users", ["unlock_token"], name: "index_admin_users_on_unlock_token", unique: true

  create_table "answerers", force: true do |t|
    t.integer  "event_id",                         null: false
    t.string   "name",                default: "", null: false
    t.integer  "total_points"
    t.integer  "correct_answers"
    t.integer  "avarage_answer_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_token"
    t.integer  "rank"
  end

  create_table "answers", force: true do |t|
    t.integer  "question_id",                           null: false
    t.integer  "answerer_id",                           null: false
    t.integer  "answer_time",                           null: false
    t.integer  "choice_question_number",                null: false
    t.boolean  "is_correct",             default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_users", ["email"], name: "index_api_users_on_email", unique: true
  add_index "api_users", ["reset_password_token"], name: "index_api_users_on_reset_password_token", unique: true

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
    t.integer  "admin_user_id"
    t.string   "name",          default: "",         null: false
    t.datetime "event_date",                         null: false
    t.datetime "limit_date",                         null: false
    t.integer  "time_limit",    default: 60,         null: false
    t.string   "url",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_delete",     default: false,      null: false
    t.integer  "course_id"
    t.string   "description"
    t.string   "url_token"
    t.boolean  "is_close",      default: true
    t.string   "status",        default: "prepared"
  end

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true

  create_table "oauth_applications", force: true do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true

  create_table "payments", force: true do |t|
    t.integer  "event_id",                   null: false
    t.datetime "date"
    t.datetime "limit_date",                 null: false
    t.integer  "amount"
    t.boolean  "is_delete",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_types", force: true do |t|
    t.string   "name",        default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
  end

  create_table "questions", force: true do |t|
    t.integer  "event_id",                              null: false
    t.integer  "question_number",  default: 1,          null: false
    t.string   "sentence",         default: "",         null: false
    t.integer  "points",           default: 1,          null: false
    t.integer  "question_type_id",                      null: false
    t.boolean  "is_delete",        default: false,      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_current"
    t.string   "status",           default: "prepared"
  end

  create_table "quiz_administrators", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quiz_administrators", ["email"], name: "index_quiz_administrators_on_email", unique: true

end
