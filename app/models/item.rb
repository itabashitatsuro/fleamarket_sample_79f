class Item < ApplicationRecord
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :images, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shopping_date
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :status
  
  belongs_to :category

  # belongs_to :seller, class_name: "User", foreign_key: 'seller_id'
  # belongs_to :buyer, class_name: "User", foreign_key: 'buyer_id'



  validates :name, presence: true, length: {maximum: 40}
  validates :price, presence: true
  validates :introduction, presence: true, length: {maximum: 1000}
  validates :prefecture, presence: true
  validates :shopping_date, presence: true
  validates :delivery_fee, presence: true
  validates :status, presence: true
  validates :image, presence: true, length: {manimum: 1, maximum: 10}

end
