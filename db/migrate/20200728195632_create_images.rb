class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :item_image, null: false

      t.timestamps
    end
  end
end
