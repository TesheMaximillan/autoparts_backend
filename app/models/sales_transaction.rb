class SalesTransaction < ApplicationRecord
  before_save :downcase_field
  belongs_to :customer

  has_many :sales, dependent: :destroy
  has_many :products, through: :sales
  has_many :stocks, through: :sales

  validates :transaction_number, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true
  validates :reference_number, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true
  validates :po_number, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true
  validates :delivery_number, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true
  validates :date, presence: true
  validates :received_by, presence: true, length: { minimum: 3, maximum: 50 }
  validates :status, presence: true, length: { minimum: 3, maximum: 50 }
  validates :vat, presence: true,
                  numericality: { greater_than_or_equal_to: 0, message: 'VAT must be greater than or equal to 0' }
  validates :withold, presence: true,
                      numericality: { greater_than_or_equal_to: 0,
                                      message: 'Withold must be greater than or equal to 0' }
  validates :other_costs, presence: true,
                          numericality: { greater_than_or_equal_to: 0,
                                          message: 'Other costs must be greater than or equal to 0' }

  private

  def downcase_field
    received_by.downcase!
    status.downcase!
  end
end
