class Transfer < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products, dependent: :destroy

  validates :date, presence: true
  validates :from, presence: true, length: { minimum: 3, maximum: 50 }
  validates :to, presence: true, length: { minimum: 3, maximum: 50 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
