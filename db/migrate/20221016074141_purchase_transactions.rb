class PurchaseTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_transactions do |t|
      t.references :vendor, null: false, foreign_key: true
      t.string :transaction_number, null: false, unique: true
      t.string :reference_number, null: false, unique: true, default: ""
      t.string :po_number, null: false, unique: true, default: ""
      t.string :delivery_number, null: false, unique: true, default: ""
      t.datetime :date, null: false
      t.string :received_by, null: false, default: ""
      t.string :status, null: false, default: "cash"
      t.decimal :vat, precision: 10, scale: 2, default: 0, null: false
      t.decimal :withold, precision: 10, scale: 2, default: 0, null: false
      t.decimal :other_costs, precision: 10, scale: 2, default: 0, null: false
      t.timestamps null: false
    end
  end
end
