# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140404094133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carriers", force: true do |t|
    t.string   "name"
    t.string   "cnpj"
    t.string   "phone"
    t.string   "address"
    t.string   "district"
    t.string   "cep"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carriers", ["city_id"], name: "index_carriers_on_city_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "region"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "celphone"
    t.string   "email"
    t.string   "skype"
    t.integer  "shipper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  add_index "contacts", ["shipper_id"], name: "index_contacts_on_shipper_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drivers", force: true do |t|
    t.string   "name"
    t.string   "cpf"
    t.string   "phone"
    t.string   "celphone"
    t.string   "address"
    t.string   "district"
    t.string   "cep"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drivers", ["city_id"], name: "index_drivers_on_city_id", using: :btree

  create_table "freight_contacts", force: true do |t|
    t.integer  "freight_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "freight_contacts", ["contact_id"], name: "index_freight_contacts_on_contact_id", using: :btree
  add_index "freight_contacts", ["freight_id"], name: "index_freight_contacts_on_freight_id", using: :btree

  create_table "freights", force: true do |t|
    t.integer  "shipper_id"
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.string   "urgency"
    t.date     "expiration"
    t.text     "description"
    t.float    "price"
    t.boolean  "tracked"
    t.boolean  "insured"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "situation"
    t.float    "width"
    t.float    "length"
    t.float    "weigth"
    t.float    "amount"
    t.float    "heigth"
    t.datetime "shipment"
  end

  add_index "freights", ["destination_id"], name: "index_freights_on_destination_id", using: :btree
  add_index "freights", ["origin_id"], name: "index_freights_on_origin_id", using: :btree
  add_index "freights", ["shipper_id"], name: "index_freights_on_shipper_id", using: :btree

  create_table "models", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "models", ["email"], name: "index_models_on_email", unique: true, using: :btree
  add_index "models", ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true, using: :btree

  create_table "shippers", force: true do |t|
    t.string   "name"
    t.string   "cnpj"
    t.string   "phone"
    t.string   "address"
    t.string   "district"
    t.string   "cep"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alternative_phone"
    t.string   "address_number"
  end

  add_index "shippers", ["city_id"], name: "index_shippers_on_city_id", using: :btree

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "acronym"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["country_id"], name: "index_states_on_country_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
