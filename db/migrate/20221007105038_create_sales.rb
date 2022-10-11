class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.string :customer_name
      t.string :reference_number
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
