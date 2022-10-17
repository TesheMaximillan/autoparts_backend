class Sale < ApplicationRecord
  belongs_to :user
  has_many :sales_transactions, dependent: :destroy
  has_many :products, through: :sales_transactions
  has_many :customers, through: :sales_transactions

  validates :vendor_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :date, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
end
