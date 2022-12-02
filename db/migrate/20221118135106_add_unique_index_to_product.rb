class AddUniqueIndexToProduct < ActiveRecord::Migration[7.0]
  def change
    add_index :products, [:name, :part_number, :status], unique: true
  end
end
