class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_and_belongs_to_many :stocks, dependent: :destroy
  has_and_belongs_to_many :transfers, dependent: :destroy

  has_many :sale_transactions, dependent: :destroy
  has_many :sale, through: :sale_transactions
  has_many :customers, through: :sale_transactions
  has_many :purchase_transactions, dependent: :destroy
  has_many :purchases, through: :purchase_transactions
  has_many :vendors, through: :purchase_transactions

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :part_number, presence: true, length: { minimum: 3, maximum: 50 }
  validates :selling, presence: true, numericality: { greater_than: 0 }
  validates :cost, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
