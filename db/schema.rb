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

ActiveRecord::Schema.define(version: 20221114031128) do

  create_table "applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "token"
    t.integer  "chats_count", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["token"], name: "index_applications_on_token", using: :btree
  end

  create_table "chats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "application_token"
    t.integer  "applications_id"
    t.integer  "chat_number"
    t.integer  "messages_count",    default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["application_token"], name: "index_chats_on_application_token", using: :btree
    t.index ["applications_id"], name: "index_chats_on_applications_id", using: :btree
    t.index ["chat_number"], name: "index_chats_on_chat_number", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "message_chat_number"
    t.integer  "chats_id"
    t.string   "message"
    t.integer  "message_number"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["chats_id"], name: "index_messages_on_chats_id", using: :btree
    t.index ["message_chat_number"], name: "index_messages_on_message_chat_number", using: :btree
    t.index ["message_number"], name: "index_messages_on_message_number", using: :btree
  end

  add_foreign_key "chats", "applications", column: "applications_id"
  add_foreign_key "messages", "chats", column: "chats_id"
end
