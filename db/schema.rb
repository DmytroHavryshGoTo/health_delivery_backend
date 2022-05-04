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

ActiveRecord::Schema.define(version: 2022_05_01_134236) do

  create_table "ads", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "description", null: false
    t.boolean "completed", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_ads_on_user_id"
  end

  create_table "deliveries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.json "route", null: false
    t.string "ttn", null: false
    t.datetime "estimated_delivery_date"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "lat"
    t.float "lon"
    t.integer "delivery_status", default: 0
    t.bigint "ad_id"
    t.index ["ad_id"], name: "index_deliveries_on_ad_id"
    t.index ["ttn"], name: "index_deliveries_on_ttn"
    t.index ["user_id"], name: "index_deliveries_on_user_id"
  end

  create_table "drugs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "delivery_id", null: false
    t.decimal "min_temperature", precision: 10, default: "0"
    t.decimal "min_humidity", precision: 10, default: "0"
    t.decimal "max_temperature", precision: 10, default: "0"
    t.decimal "max_humidity", precision: 10, default: "0"
    t.string "name", null: false
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "container_id"
    t.integer "quantity", null: false
    t.index ["delivery_id"], name: "index_drugs_on_delivery_id"
  end

  create_table "dumps", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_dumps_on_user_id"
  end

  create_table "trackable_deliveries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "delivery_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["delivery_id"], name: "index_trackable_deliveries_on_delivery_id"
    t.index ["user_id"], name: "index_trackable_deliveries_on_user_id"
  end

  create_table "user_sessions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
    t.index ["uuid"], name: "index_user_sessions_on_uuid"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "need_help", default: false, null: false
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "deliveries", "users"
  add_foreign_key "drugs", "deliveries"
  add_foreign_key "dumps", "users"
  add_foreign_key "trackable_deliveries", "deliveries"
  add_foreign_key "trackable_deliveries", "users"
  add_foreign_key "user_sessions", "users"
end
