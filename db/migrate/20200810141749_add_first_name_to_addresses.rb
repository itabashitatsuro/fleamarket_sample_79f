class AddFirstNameToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :first_name, :string
  end
end
