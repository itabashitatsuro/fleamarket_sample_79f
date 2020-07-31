class Item < ApplicationRecord
 
  belongs_to :user
  belongs_to :category
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images
  has_many :comments, dependent: :destroy
  has_many :favorites  

  validates :name, presence: true, length: { maximum: 40 }
  validates :item_images, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :introduction, presence: true, length: { maximum: 1000 }
  validates :prefecture, presence: true
  validates :postgate, presence: true
  validates :delivery_fee, presence: true
  validates :shipping_date, presence: true
  validates :area, presence: true
  validates :category, presence: true
  validates :buyer_id, presence: true

  mount_uploader :item_image, ImageUploader
  
end
