class Item < ApplicationRecord
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :images, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shopping_date
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :status



  validates :name, length: {maximum: 10}, presence: true
  validates :price, presence: true
  validates :introduction, presence: true
  validates :brand, presence: true
  validates :prefecture, presence: true
  validates :shopping_date, presence: true
  validates :delivery_fee, presence: true
  validates :status, presence: true

end
