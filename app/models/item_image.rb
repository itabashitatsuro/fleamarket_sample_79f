class ItemImage < ApplicationRecord
  belongs_to :item, dependent: :destroy
  validates :url, presence:
end
