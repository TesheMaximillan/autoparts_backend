class StockManagements < ActiveRecord::Migration[7.0]
  def change
    create_join_table :stocks, :products
  end
end
