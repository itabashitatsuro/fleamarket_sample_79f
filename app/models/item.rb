class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipping_date
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :status

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :images, dependent: :destroy
  belongs_to :user
  belongs_to :category

  # belongs_to :seller, class_name: "User", foreign_key: 'seller_id'
  # belongs_to :buyer, class_name: "User", foreign_key: 'buyer_id'

  # validates :image, presence: true, length: {manimum: 1, maximum: 10}
  validates :name, presence: true, length: {maximum: 40}
  validates :introduction, presence: true, length: {maximum: 1000}
  validates :category, presence: true
  validates :status_id, presence: true
  validates :delivery_fee_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_date_id, presence: true
  validates :price, presence: true
  
end