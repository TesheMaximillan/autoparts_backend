class TransferTransaction < ActiveRecord::Migration[7.0]
  def change
    create join_table :transfers, :products
  end
end
