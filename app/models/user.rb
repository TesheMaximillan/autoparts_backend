class User < ApplicationRecord
  has_secure_password
  # has_many :stocks, dependent: :destroy
  # has_many :customers, dependent: :destroy
  # has_many :vendors, dependent: :destroy
  # has_many :categories, dependent: :destroy
  # has_many :sales, dependent: :destroy
  # has_many :purchases, dependent: :destroy
  # has_many :products, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates :full_name, presence: true, length: { minimum: 3, maximum: 20 }
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/
  validates :email, presence: true, uniqueness: true,
                    format: { with: EMAIL_REGEX, message: 'Please enter a valid email address' }
end
