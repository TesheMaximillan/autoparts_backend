class PurchaseTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_transactions do |t|
      t.references :product, null: false, foreign_key: true
      t.references :purchase, null: false, foreign_key: true
      t.references :vendor, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
