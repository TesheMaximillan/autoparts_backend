class Stock < ApplicationRecord
  # belongs_to :user
  has_many :stock_products, dependent: :destroy
  has_many :products, through: :stock_products

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true

  before_save :downcase_field

  def downcase_field
    name.downcase!
  end
end
