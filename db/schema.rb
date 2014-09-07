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

ActiveRecord::Schema.define(version: 20140907215635) do

  create_table "projects", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "complete"
    t.text     "description"
    t.integer  "created_by_id"
  end

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.integer  "task_type"
    t.date     "deadline"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "person_responsible_id"
    t.integer  "created_by_id"
  end

  add_index "tasks", ["created_by_id"], name: "index_tasks_on_created_by_id"
  add_index "tasks", ["person_responsible_id"], name: "index_tasks_on_person_responsible_id"
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "gender"
    t.string   "email"
    t.string   "password"
    t.boolean  "is_active"
    t.date     "birthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
