class Customer < ApplicationRecord
  # belongs_to :user
  has_many :sale_transactions, dependent: :destroy
  has_many :products, through: :sale_transactions
  has_many :sales, through: :sale_transactions

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  before_save :downcase_field

  def downcase_field
    name.downcase!
  end
end
