class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.string :company_name, default: "Your Stock", null: false
      t.integer :main_store, default: 1, null: false
      t.boolean :selling_in_percent, default: false, null: false
      t.boolean :vat, default: false, null: false
      t.boolean :withould, default: false, null: false
      t.boolean :other_tax, default: false, null: false
      t.boolean :fs_number, default: false, null: false
      t.boolean :po_number, default: false, null: false
      t.boolean :delivery_number, default: false, null: false
      t.boolean :received_by, default: false, null: false
      t.boolean :status, default: false, null: false
      t.boolean :brand, default: false, null: false
      t.boolean :cost, default: false, null: false
      t.boolean :selling, default: false, null: false

      t.timestamps
    end
  end
end
