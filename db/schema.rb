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

ActiveRecord::Schema[7.1].define(version: 2024_01_21_132828) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disbursements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reference"
    t.string "merchant_reference"
    t.decimal "amount", precision: 20, scale: 2
    t.decimal "fee", precision: 20, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_reference"], name: "index_disbursements_on_merchant_reference"
    t.index ["reference", "merchant_reference"], name: "index_disbursements_on_reference_and_merchant_reference", unique: true
    t.index ["reference"], name: "index_disbursements_on_reference", unique: true
  end

  create_table "merchants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reference"
    t.string "email"
    t.datetime "live_on"
    t.string "disbursement_frequency"
    t.decimal "minimum_monthly_fee", precision: 6, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference"], name: "index_merchants_on_reference", unique: true
  end

  create_table "orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "merchant_reference"
    t.string "disbursement_reference"
    t.decimal "amount", precision: 20, scale: 2
    t.boolean "disbursed", default: false
    t.string "shopper_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disbursed"], name: "index_orders_on_disbursed"
    t.index ["disbursement_reference"], name: "index_orders_on_disbursement_reference"
    t.index ["merchant_reference"], name: "index_orders_on_merchant_reference"
    t.index ["shopper_reference"], name: "index_orders_on_shopper_reference"
  end

end
