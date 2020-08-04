class RemoveBuyerIdFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :buyer_id, :string
  end
end
