class Purchase < ApplicationRecord
  belongs_to :user
  has_many :purchase_transactions, dependent: :destroy
  has_many :products, through: :purchase_transactions
  has_many :vendors, through: :purchase_transactions

  validates :date, presence: true
  validates :received_by, length: { minimum: 3, maximum: 50 }
  validates :reference_number, presence: true, length: { minimum: 3, maximum: 50 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, length: { minimum: 3, maximum: 50 }
end
