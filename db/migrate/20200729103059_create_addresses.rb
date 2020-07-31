class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :postal_code, null: false
      t.string :prefecture
      t.string :city
      t.string :house_number
      t.string :apartment
      t.string :contact
      t.timestamps
    end
  end
end
