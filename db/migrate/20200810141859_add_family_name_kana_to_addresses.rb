class AddFamilyNameKanaToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :family_name_kana, :string
  end
end
