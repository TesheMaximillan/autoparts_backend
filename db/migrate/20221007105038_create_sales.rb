class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.date :date
      t.string :received_by
      t.string :reference_number
      t.string :status
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
