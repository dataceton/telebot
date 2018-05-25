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

ActiveRecord::Schema.define(version: 20180319101331) do

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "order_id"
    t.string "name"
    t.integer "price"
    t.integer "weight"
    t.float "latitude"
    t.float "longitude"
    t.string "photo"
    t.text "description"
    t.string "description_image"
    t.integer "code"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_products_on_code"
    t.index ["order_id"], name: "index_products_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "telegram_id"
    t.string "first_name"
    t.string "last_name"
    t.string "bot_command_data"
    t.integer "sale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "balance", default: 0
    t.integer "code"
    t.index ["code"], name: "index_wallets_on_code"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

end
