class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.string :from
      t.string :to
      t.integer :quantity

      t.timestamps
    end
  end
end
