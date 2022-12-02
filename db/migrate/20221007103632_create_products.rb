class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.string :part_number, null: false
      t.string :brand, default: "N/A"
      t.string :status, default: "N/A"
      t.decimal :selling, precision: 10, scale: 2, default: 0, null: false
      t.decimal :cost, precision: 10, scale: 2, default: 0, null: false

      t.timestamps
    end
  end
end
