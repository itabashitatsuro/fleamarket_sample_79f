class RemoveItemImagesIdFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :item_images_id, :integer
  end
end
