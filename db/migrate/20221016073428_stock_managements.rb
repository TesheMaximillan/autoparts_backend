class StockManagements < ActiveRecord::Migration[7.0]
  def change
    create join_table :stocks, :products
  end
end
