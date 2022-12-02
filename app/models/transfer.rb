class Transfer < ApplicationRecord
  belongs_to :product
  validates :date, presence: true
  validates :from, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :to, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
