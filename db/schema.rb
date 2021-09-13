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

ActiveRecord::Schema.define(version: 2021_08_25_024353) do

  create_table "orders", force: :cascade do |t|
    t.string "email"
    t.string "card_number"
    t.string "card_expiration_date"
    t.string "card_verification"
    t.string "bill_firstname"
    t.string "bill_lastname"
    t.string "bill_address1"
    t.string "bill_address2"
    t.string "bill_city"
    t.string "bill_state"
    t.string "bill_zipcode"
    t.string "ship_firstname"
    t.string "ship_lastname"
    t.string "ship_address1"
    t.string "ship_address2"
    t.string "ship_city"
    t.string "ship_state"
    t.string "ship_zipcode"
    t.string "phone"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.text "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
