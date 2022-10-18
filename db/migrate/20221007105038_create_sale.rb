class CreateSale < ActiveRecord::Migration[7.0]
  def change
    create_table :sale do |t|
      t.references :user, null: false, foreign_key: true
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
