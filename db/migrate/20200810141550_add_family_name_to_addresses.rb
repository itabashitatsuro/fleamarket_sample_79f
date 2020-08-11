class AddFamilyNameToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :family_name, :string
  end
end
