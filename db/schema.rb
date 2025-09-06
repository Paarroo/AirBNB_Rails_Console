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

ActiveRecord::Schema[8.0].define(version: 2025_06_07_093323) do
  create_table "accommodations", force: :cascade do |t|
    t.integer "available_beds", null: false
    t.integer "price", null: false
    t.text "description", null: false
    t.boolean "has_wifi", default: true, null: false
    t.text "welcome_message", null: false
    t.integer "owner_id", null: false
    t.integer "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available_beds"], name: "index_accommodations_on_available_beds"
    t.index ["city_id", "price"], name: "index_accommodations_on_city_id_and_price"
    t.index ["city_id"], name: "index_accommodations_on_city_id"
    t.index ["has_wifi"], name: "index_accommodations_on_has_wifi"
    t.index ["owner_id"], name: "index_accommodations_on_owner_id"
    t.index ["price"], name: "index_accommodations_on_price"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", unique: true
    t.index ["zip_code"], name: "index_cities_on_zip_code", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "guest_id", null: false
    t.integer "accommodation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accommodation_id", "start_date"], name: "index_reservations_on_accommodation_id_and_start_date"
    t.index ["accommodation_id"], name: "index_reservations_on_accommodation_id"
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["start_date", "end_date"], name: "index_reservations_on_start_date_and_end_date"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

  add_foreign_key "accommodations", "cities"
  add_foreign_key "accommodations", "users", column: "owner_id"
  add_foreign_key "reservations", "accommodations"
  add_foreign_key "reservations", "users", column: "guest_id"
end
