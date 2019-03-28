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
ActiveRecord::Schema.define(version: 20190309142759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "android_debug_messages", force: :cascade do |t|
    t.json "payload"
    t.string "uuid"
    t.string "from_device_id"
    t.string "from_device_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "claims", force: :cascade do |t|
    t.string "file"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clusterdata", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_type"
    t.json "payload"
    t.string "device_id"
    t.string "uuid"
    t.string "device_type"
	end

  create_table "deployment_test_reports", force: :cascade do |t|
    t.string "name"
    t.json "results"
    t.string "message_success_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_observations", force: :cascade do |t|
    t.string "device_id"
    t.string "device_type"
    t.string "latitude"
    t.string "longitude"
    t.datetime "observation_timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_type"
    t.string "device_id"
    t.string "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incidents", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "managers"
    t.integer "impacted"
    t.integer "casualties"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "sender"
    t.integer "recipient"
    t.text "message"
    t.string "file"
    t.boolean "read"
    t.string "mtype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "priorities", force: :cascade do |t|
    t.string "name"
    t.string "level"
    t.text "details"
    t.integer "incident_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.string "quantity"
    t.string "location"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_token"
    t.string "password_digest"
    t.integer "incident"
  end

end
