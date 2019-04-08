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

ActiveRecord::Schema.define(version: 2019_04_01_161450) do

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image_file_name", default: ""
    t.string "gm"
    t.string "players"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.integer "user_id"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.index ["campaign_id"], name: "index_games_on_campaign_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.string "title"
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "campaign_id"
    t.index ["campaign_id"], name: "index_meetings_on_campaign_id"
  end

  create_table "signups", force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_signups_on_campaign_id"
    t.index ["user_id"], name: "index_signups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
  end

end
