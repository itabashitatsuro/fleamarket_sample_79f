class RemovePostageFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :postage, :string
  end
end
