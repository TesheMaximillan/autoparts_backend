class ProductPurchase < ActiveRecord::Migration[7.0]
  def change
    create_join_table :products, :purchases
  end
end
