class Stock < ApplicationRecord
  # belongs_to :user
  has_many :stock_products, dependent: :destroy
  has_many :products, through: :stock_products
  has_many :sales, dependent: :destroy
  has_many :sales_transactions, through: :sales
  has_many :purchases, dependent: :destroy
  has_many :purchase_transactions, through: :purchases

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true

  before_save :downcase_field

  def downcase_field
    name.downcase!
  end
end
