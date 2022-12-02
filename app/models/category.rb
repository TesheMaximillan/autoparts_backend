class Category < ApplicationRecord
  has_many :products
  # belongs_to :user
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }

  before_save :downcase_field

  def downcase_field
    name.downcase!
  end
end
