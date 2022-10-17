class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.string :part_number
      t.integer :quantity
      t.decimal :sale_price, precision: 8, scale: 2
      t.decimal :purchase_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
