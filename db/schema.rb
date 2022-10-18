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

ActiveRecord::Schema[7.0].define(version: 2022_10_18_171145) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.string "name", null: false
    t.string "part_number"
    t.integer "quantity"
    t.decimal "selling", precision: 8, scale: 2
    t.decimal "cost", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "products_stocks", id: false, force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.bigint "product_id", null: false
  end

  create_table "products_transfers", id: false, force: :cascade do |t|
    t.bigint "transfer_id", null: false
    t.bigint "product_id", null: false
  end

  create_table "purchase_transactions", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "purchase_id", null: false
    t.bigint "vendor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchase_transactions_on_product_id"
    t.index ["purchase_id"], name: "index_purchase_transactions_on_purchase_id"
    t.index ["vendor_id"], name: "index_purchase_transactions_on_vendor_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.string "received_by"
    t.string "reference_number"
    t.string "status"
    t.integer "quantity"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "sale_transactions", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "customer_id", null: false
    t.bigint "sale_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_sale_transactions_on_customer_id"
    t.index ["product_id"], name: "index_sale_transactions_on_product_id"
    t.index ["sale_id"], name: "index_sale_transactions_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.string "received_by"
    t.string "reference_number"
    t.string "status"
    t.integer "quantity"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.string "from"
    t.string "to"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_transfers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name", null: false
    t.string "username", default: "", null: false
    t.string "password_digest"
    t.string "role", default: "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vendors_on_user_id"
  end

  add_foreign_key "categories", "users"
  add_foreign_key "customers", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "users"
  add_foreign_key "purchase_transactions", "products"
  add_foreign_key "purchase_transactions", "purchases"
  add_foreign_key "purchase_transactions", "vendors"
  add_foreign_key "purchases", "users"
  add_foreign_key "sale_transactions", "customers"
  add_foreign_key "sale_transactions", "products"
  add_foreign_key "sale_transactions", "sales"
  add_foreign_key "sales", "users"
  add_foreign_key "stocks", "users"
  add_foreign_key "transfers", "users"
  add_foreign_key "vendors", "users"
end
