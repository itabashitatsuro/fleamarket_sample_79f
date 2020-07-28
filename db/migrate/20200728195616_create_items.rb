class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null:false, index: true, limit: 191 #商品名
      t.text :introduction, null:false # 商品説明
      t.string :brand #ブランド
      t.integer :status_id, null: false #商品の状態
      t.integer :delivery_fee_id, null: false #配送料の負担
      t.integer :prefecture_id, null: false #発送元の地域
      t.integer :shopping_date_id, null: false #発送までの日数
      t.integer :price, null: false #販売価格
      
      t.timestamps
    end
  end
end