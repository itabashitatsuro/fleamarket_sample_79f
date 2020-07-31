class Item < ApplicationRecord
  # belongs_to: user
  belongs_to: category
  # has_many: item_images,dependent：：destroy
  # has_many: comments、dependent：：destroy
  # has_many: favorites

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shopping_date

  
end
