class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :postal_code, null: false
      t.integer :user_id
      t.integer :prefecture_id
      t.string :first_name
      t.string :family_name
      t.string :first_name_kana
      t.string :family_name_kana
      t.string :city
      t.string :house_number
      t.string :apartment
      t.string :contact
      t.timestamps
    end
  end
end
