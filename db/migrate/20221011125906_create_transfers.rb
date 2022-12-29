class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.references :product, null: false, foreign_key: true
      t.date :date
      t.integer :from
      t.integer :to
      t.integer :quantity

      t.timestamps
    end
  end
end
