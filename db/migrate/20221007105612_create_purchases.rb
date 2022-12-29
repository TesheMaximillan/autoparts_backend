class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.references :stock, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :purchase_transaction, null: false, foreign_key: true

      t.integer :quantity, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.timestamps
    end
  end
end
