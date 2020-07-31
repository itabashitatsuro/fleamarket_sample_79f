class Address < ApplicationRecord
  belongs_to :user
  validates :postal_code, presence: true,
  validates :prefecture, presence: true,
  validates :city, presence: true,
  validates :address, presence: true,
  validates :apartment, presence: true,
end
