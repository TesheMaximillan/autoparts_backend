class Purchase < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products, dependent: :destroy, join_table: :purchases_products

  validates :vendor_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :date, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
end
