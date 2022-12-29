class Product < ApplicationRecord
  belongs_to :category
  # belongs_to :user

  has_many :stock_products, dependent: :destroy
  has_many :stocks, through: :stock_products
  has_many :sales, dependent: :destroy
  has_many :sales_transactions, through: :sales
  has_many :purchases, dependent: :destroy
  has_many :purchase_transactions, through: :purchases
  has_many :transfers

  validates :name, presence: true,
                   length: { minimum: 3, maximum: 50, message: 'Name must be between 3 and 50 characters' }
  validates_uniqueness_of :name, scope: %i[part_number status], message: 'Product already exists'
  validates :part_number, presence: true,
                          length: { minimum: 3, maximum: 50,
                                    message: 'Part number must be between 3 and 50 characters' }
  validates :brand, presence: true,
                    length: { minimum: 3, maximum: 50, message: 'Brand must be between 3 and 50 characters' }
  validates :status, presence: true,
                     length: { minimum: 3, maximum: 50, message: 'Status must be between 3 and 50 characters' }
  validates :cost, presence: true,
                   numericality: { greater_than_or_equal_to: 0, message: 'Cost must be greater than or equal to 0' }
  validates :selling, presence: true,
                      numericality: { greater_than_or_equal_to: :cost,
                                      message: 'Selling price must be greater than or equal to cost' }

  before_save :downcase_field
  def downcase_field
    name.downcase!
    part_number.downcase!
    brand.downcase!
    status.downcase!
  end
end
