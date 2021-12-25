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

ActiveRecord::Schema.define(version: 2021_12_25_170357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ambulance_bookings", force: :cascade do |t|
    t.integer "ambulance_id", null: false
    t.text "destination", null: false
    t.text "origin", null: false
    t.integer "amount_to_pay", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "appointment_bookngs", force: :cascade do |t|
    t.integer "doctor_id", null: false
    t.datetime "expires_at", precision: 6, null: false
    t.integer "amount_to_pay", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.string "bookable_type"
    t.bigint "bookable_id"
    t.string "uuid", null: false
    t.string "patient_id"
    t.datetime "booking_time", precision: 6, null: false
    t.string "status", null: false
    t.text "description"
    t.text "metadata"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bookable_type", "bookable_id"], name: "index_bookings_on_bookable"
  end

  create_table "lab_test_bookings", force: :cascade do |t|
    t.integer "lab_id", null: false
    t.datetime "expires_at", precision: 6, null: false
    t.integer "amount_to_pay", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "country_code"
    t.string "phone"
    t.boolean "blocked", default: false
    t.datetime "birthdate", precision: 6, null: false
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest", default: "", null: false
  end

end
