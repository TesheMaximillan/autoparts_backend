class SaleTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :sale_transactions do |t|
      t.references :sale, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
