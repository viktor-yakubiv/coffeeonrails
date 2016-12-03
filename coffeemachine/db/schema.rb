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

ActiveRecord::Schema.define(version: 20161203201741) do

  create_table "drinks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "amount_left"
    t.float    "price",       limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ingredients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "amount_left"
    t.float    "price",       limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ingredients_orders", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "order_id"
    t.integer "ingredient_id"
    t.index ["ingredient_id"], name: "index_orders_ingredients_on_ingredient_id", using: :btree
    t.index ["order_id"], name: "index_orders_ingredients_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "order_sum",  limit: 24
    t.integer  "user_id"
    t.integer  "drink_id"
    t.datetime "performed"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["drink_id"], name: "index_orders_on_drink_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "password"
    t.float    "money_left", limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "is_admin"
  end

end
