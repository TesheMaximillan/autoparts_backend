class PurchaseTransaction < ApplicationRecord
  belongs_to :product
  belongs_to :purchase
  belongs_to :vendor
end
