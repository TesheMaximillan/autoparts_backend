class Vendor < ApplicationRecord
  # belongs_to :user
  has_many :purchase_transactions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  before_save :downcase_field

  def downcase_field
    name.downcase!
  end
end
