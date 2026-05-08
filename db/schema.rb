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

ActiveRecord::Schema[8.1].define(version: 2026_04_30_081747) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "daily_slot_status", ["open", "closed_regular", "closed_temp", "suspended"]
  create_enum "person_type", ["adult", "student", "child", "infant"]
  create_enum "reservation_status", ["pending", "confirmed", "visited", "cancelled"]

  create_table "daily_slots", primary_key: "applicable_date", id: :date, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "max_capacity"
    t.bigint "price_id"
    t.enum "status", default: "open", null: false, enum_type: "daily_slot_status"
    t.datetime "updated_at", null: false
    t.index ["price_id"], name: "index_daily_slots_on_price_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "adult_price", null: false
    t.integer "child_price", null: false
    t.datetime "created_at", null: false
    t.integer "infant_price", null: false
    t.string "price_name", null: false
    t.integer "student_price", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "personal_name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["email"], name: "index_profiles_on_email", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "reservation_details", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "number_of_people", null: false
    t.enum "person_type", null: false, enum_type: "person_type"
    t.integer "price", null: false
    t.bigint "reservation_id", null: false
    t.integer "subtotal", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id", "person_type"], name: "idx_reservation_details_on_reservation_and_type", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "daily_slot_date", null: false
    t.string "email", null: false
    t.string "personal_name", null: false
    t.string "res_code", limit: 10, null: false
    t.enum "status", default: "pending", null: false, enum_type: "reservation_status"
    t.integer "total_price", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_slot_date", "status"], name: "idx_reservations_on_date_and_status"
    t.index ["res_code"], name: "index_reservations_on_res_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "daily_slots", "prices"
  add_foreign_key "profiles", "users"
  add_foreign_key "reservation_details", "reservations"
  add_foreign_key "reservations", "daily_slots", column: "daily_slot_date", primary_key: "applicable_date"
end
