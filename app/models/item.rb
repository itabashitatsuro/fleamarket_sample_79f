class Item < ApplicationRecord
  # belongs_to: user
  # has_many: item_images,dependent：：destroy
  # has_many: comments、dependent：：destroy
  # has_many: favorites

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :ShippingDate
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_fee

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :images, dependent: :destroy
  

  belongs_to :category


  validates :image, presence: true, length: {manimum: 1, maximum: 10}
  validates :name, presence: true, length: {maximum: 40}
  validates :introduction, presence: true, length: {maximum: 1000}
  validates :category, presence: true
  validates :status_id, presence: true
  validates :delivery_fee_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_date_id, presence: true
  validates :price, presence: true
  
end
