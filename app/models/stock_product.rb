class StockProduct < ApplicationRecord
  belongs_to :stock
  belongs_to :product

  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 0,
                                       message: 'Quantity must be greater than or equal to 0' }
end
