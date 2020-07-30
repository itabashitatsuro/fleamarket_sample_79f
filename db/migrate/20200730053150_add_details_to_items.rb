class AddDetailsToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :category, null: false, foreign_key: true
    add_reference :items, :buyer, foreign_key: true
    add_reference :items, :seller, null:false, foreign_key: true
  end
end
