class CreateShoppingDates < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_dates do |t|
      t.string :name, null:false

      t.timestamps
    end
  end
end
