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

ActiveRecord::Schema.define(version: 2022_01_30_112913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ambulance_bookings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "ambulance_id", null: false
    t.text "destination", null: false
    t.text "origin", null: false
    t.integer "amount_to_pay", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ambulances", force: :cascade do |t|
    t.string "vehicle_number", null: false
    t.boolean "booked"
    t.boolean "blocked", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "appointment_bookings", id: :bigint, default: -> { "nextval('appointment_bookngs_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "doctor_id", null: false
    t.datetime "expires_at", precision: 6, null: false
    t.integer "amount_to_pay", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "doctor_slot_id", null: false
    t.integer "slot_number", null: false
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
    t.index ["bookable_type", "bookable_id"], name: "index_bookings_on_bookable_type_and_bookable_id"
  end

  create_table "designations", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
  end

  create_table "doctor_slots", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "location_id", null: false
    t.string "days_of_week", default: "0000000", null: false
    t.integer "checkup_duration", null: false
    t.text "slot_template", default: "{}", null: false
    t.text "bookings", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id", "location_id"], name: "index_doctor_slots_on_doctor_id_and_location_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "salutation", null: false
    t.string "name", null: false
    t.string "country_code"
    t.string "phone"
    t.string "email", null: false
    t.datetime "birthdate", precision: 6, null: false
    t.boolean "blocked", default: false
    t.string "password_digest", default: "", null: false
    t.string "designation_slugs"
    t.string "years_experience", default: "0", null: false
    t.string "speciality_ids"
    t.string "location_ids", null: false
    t.string "registration_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_doctors_on_email", unique: true
    t.index ["registration_number"], name: "index_doctors_on_registration_number", unique: true
  end

  create_table "lab_test_bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "lab_id", null: false
    t.datetime "expires_at", precision: 6, null: false
    t.integer "amount_to_pay", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "labs", force: :cascade do |t|
    t.text "name", null: false
    t.text "address"
    t.integer "location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "registration_number", null: false
    t.boolean "blacklisted", default: false, null: false
    t.index ["registration_number"], name: "index_labs_on_registration_number", unique: true
  end

  create_table "location_services", force: :cascade do |t|
    t.bigint "location_id"
    t.string "services"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_location_services_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "city", null: false
    t.string "state_code", null: false
    t.string "zip_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "coordinates"
    t.index ["zip_code", "state_code"], name: "index_locations_on_zip_code_and_state_code", unique: true
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id"
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "revoked_at", precision: 6
    t.string "scopes", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "specialities", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.index ["slug"], name: "index_specialities_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "type", null: false
    t.string "salutation", null: false
    t.string "name", null: false
    t.string "country_code"
    t.string "phone"
    t.string "email"
    t.datetime "birthdate", precision: 6, null: false
    t.boolean "blocked", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest", default: "", null: false
    t.index ["country_code", "phone", "type"], name: "index_users_on_country_code_and_phone_and_type"
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
