class Item < ApplicationRecord
  # belongs_to: user
  # has_many: item_images,dependent：：destroy
  # has_many: comments、dependent：：destroy
  # has_many: favorites

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shopping_date
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_fee


  belongs_to :category
  has_many :images


  validates :name, presence: true, length: {maximum: 40}
  validates :price, presence: true
  validates :introduction, presence: true, length: {maximum: 1000}
  validates :prefecture, presence: true
  validates :shopping_date, presence: true
  validates :delivery_fee, presence: true
  validates :status, presence: true
  validates :image, presence: true, length: {manimum: 1, maximum: 10}
  
end
