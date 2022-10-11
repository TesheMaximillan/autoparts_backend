class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_and_belongs_to_many :purchases, dependent: :destroy, join_table: :purchases_products
  has_and_belongs_to_many :sales, dependent: :destroy, join_table: :sales_products

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :part_number, presence: true, length: { minimum: 3, maximum: 50 }
end
