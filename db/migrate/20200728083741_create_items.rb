class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.integer :item_images_id
      t.integer :price, null: false
      t.text :introduction
      t.integer :status, null: false
      t.string :prefecture, null: false
      t.string :postage, null: false
      t.integer :shipping_date, null: false
      t.integer :delivery_fee, null: false
      t.string :area, null: false
      t.integer :buyer_id  
      t.timestamps
    end
  end
end
