class SalesTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table sales_transactions do |t|
      t.references :product, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :sales, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
