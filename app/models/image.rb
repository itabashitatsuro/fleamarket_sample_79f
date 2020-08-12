class Image < ApplicationRecord
  belongs_to :item
  mount_uploader :item_image, ImageUploader
  
end
