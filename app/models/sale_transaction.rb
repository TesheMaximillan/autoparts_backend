class SaleTransaction < ApplicationRecord
  belongs_to :product
  belongs_to :sale
  belongs_to :customer
end
