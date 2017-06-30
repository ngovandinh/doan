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

ActiveRecord::Schema.define(version: 20170617050353) do

  create_table "answers", force: :cascade do |t|
    t.integer  "quession_id"
    t.string   "content"
    t.boolean  "is_correct",  default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "answers", ["quession_id"], name: "index_answers_on_quession_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "information"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "lessions", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "lessions", ["category_id"], name: "index_lessions_on_category_id"

  create_table "quessions", force: :cascade do |t|
    t.integer  "lession_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "quessions", ["lession_id"], name: "index_quessions_on_lession_id"

  create_table "sentences", force: :cascade do |t|
    t.integer  "test_id"
    t.integer  "quession_id"
    t.integer  "answer_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "mixedanswer", default: ""
  end

  add_index "sentences", ["answer_id"], name: "index_sentences_on_answer_id"
  add_index "sentences", ["quession_id"], name: "index_sentences_on_quession_id"
  add_index "sentences", ["test_id"], name: "index_sentences_on_test_id"

  create_table "tests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lession_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.datetime "started_at"
    t.datetime "finnished_at"
    t.string   "status",       default: "none"
  end

  add_index "tests", ["lession_id"], name: "index_tests_on_lession_id"
  add_index "tests", ["user_id"], name: "index_tests_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "avatar"
    t.string   "address"
    t.string   "phone"
    t.string   "password_digest"
    t.string   "is_admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "uid"
    t.string   "provider"
  end

end
