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

ActiveRecord::Schema[7.0].define(version: 2022_11_27_194152) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name", null: false
    t.string "part_number", null: false
    t.string "brand", default: "N/A"
    t.string "status", default: "N/A"
    t.decimal "selling", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "cost", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["name", "part_number", "status"], name: "index_products_on_name_and_part_number_and_status", unique: true
  end

  create_table "purchase_transactions", force: :cascade do |t|
    t.bigint "vendor_id", null: false
    t.string "transaction_number", null: false
    t.string "reference_number", default: "", null: false
    t.string "po_number", default: "", null: false
    t.string "delivery_number", default: "", null: false
    t.datetime "date", null: false
    t.string "received_by", default: "", null: false
    t.string "status", default: "cash", null: false
    t.decimal "vat", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "withold", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "other_costs", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vendor_id"], name: "index_purchase_transactions_on_vendor_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.bigint "product_id", null: false
    t.bigint "purchase_transaction_id", null: false
    t.integer "quantity", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["purchase_transaction_id"], name: "index_purchases_on_purchase_transaction_id"
    t.index ["stock_id"], name: "index_purchases_on_stock_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.bigint "product_id", null: false
    t.bigint "sales_transaction_id", null: false
    t.integer "quantity", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sales_on_product_id"
    t.index ["sales_transaction_id"], name: "index_sales_on_sales_transaction_id"
    t.index ["stock_id"], name: "index_sales_on_stock_id"
  end

  create_table "sales_transactions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "transaction_number", null: false
    t.string "reference_number", default: "", null: false
    t.string "po_number", default: "", null: false
    t.string "delivery_number", default: "", null: false
    t.datetime "date", null: false
    t.string "received_by", default: "", null: false
    t.string "status", default: "cash", null: false
    t.decimal "vat", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "withold", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "other_costs", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_sales_transactions_on_customer_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "company_name", default: "Your Stock", null: false
    t.integer "main_store", default: 1, null: false
    t.boolean "selling_in_percent", default: false, null: false
    t.boolean "vat", default: false, null: false
    t.boolean "withould", default: false, null: false
    t.boolean "other_tax", default: false, null: false
    t.boolean "fs_number", default: false, null: false
    t.boolean "po_number", default: false, null: false
    t.boolean "delivery_number", default: false, null: false
    t.boolean "received_by", default: false, null: false
    t.boolean "status", default: false, null: false
    t.boolean "brand", default: false, null: false
    t.boolean "cost", default: false, null: false
    t.boolean "selling", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_products", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "stock_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stock_products_on_product_id"
    t.index ["stock_id"], name: "index_stock_products_on_stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.date "date"
    t.integer "from"
    t.integer "to"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_transfers_on_product_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "products", "categories"
  add_foreign_key "purchase_transactions", "vendors"
  add_foreign_key "purchases", "products"
  add_foreign_key "purchases", "purchase_transactions"
  add_foreign_key "purchases", "stocks"
  add_foreign_key "sales", "products"
  add_foreign_key "sales", "sales_transactions"
  add_foreign_key "sales", "stocks"
  add_foreign_key "sales_transactions", "customers"
  add_foreign_key "stock_products", "products"
  add_foreign_key "stock_products", "stocks"
  add_foreign_key "transfers", "products"
end
