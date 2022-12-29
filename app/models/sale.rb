class Sale < ApplicationRecord
  # belongs_to :user

  belongs_to :product
  belongs_to :stock
  belongs_to :sales_transaction

  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 1,
                                       message: 'Quantity must be greater than or equal to 1' }
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0, message: 'Price must be greater than or equal to 0' }
end
