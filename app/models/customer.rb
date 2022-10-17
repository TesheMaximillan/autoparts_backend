class Customer < ApplicationRecord
  belongs_to :user
  has_many :sales_transactions, dependent: :destroy
  has_many :products, through: :sales_transactions
  has_many :sales, through: :sales_transactions

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
end
