class ProductSales < ActiveRecord::Migration[7.0]
  def change
    create_join_table :products, :sales
  end
end
