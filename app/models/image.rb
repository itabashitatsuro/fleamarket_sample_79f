class Image < ApplicationRecord
  belongs_to :item
  mount_uploader :item_image, ImageUploader

  validates :image, presence: true, length: {manimum: 1, maximum: 5}
end
