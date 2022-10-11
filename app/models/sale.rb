class Sale < ApplicationRecord
  has_and_belongs_to_many :products, dependent: :destroy, join_table: :sales_products
  belongs_to :user

  validates :vendor_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :date, presence: true, date: { before_or_equal_to: Date.today }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
end
