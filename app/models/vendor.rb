class Vendor < ApplicationRecord
  # belongs_to :user
  has_many :purchase_transactions, dependent: :destroy
  has_many :products, through: :purchase_transactions
  has_many :purchases, through: :purchase_transactions

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  before_save :downcase_field

  def downcase_field
    name.downcase!
  end
end
