# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_07_221849) do

  create_table "attachments", force: :cascade do |t|
    t.string "title"
    t.string "path"
  end

  create_table "project_members", force: :cascade do |t|
    t.integer "project_id"
    t.integer "member_id"
    t.integer "role"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "creator"
    t.integer "attachment_id"
  end

  create_table "role_types", force: :cascade do |t|
    t.string "role_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.integer "age"
    t.string "password"
    t.string "email"
  end

end
