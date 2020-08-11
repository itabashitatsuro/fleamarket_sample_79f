class AddFirstNameKanaToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :first_name_kana, :string
  end
end
