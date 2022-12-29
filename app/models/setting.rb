class Setting < ApplicationRecord
  validates :company_name, presence: true,
                           length: { minimum: 3, maximum: 50, message: 'Name must be between 3 and 50 characters' }
end
