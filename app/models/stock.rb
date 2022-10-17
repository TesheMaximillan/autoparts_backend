class Stock < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
end
