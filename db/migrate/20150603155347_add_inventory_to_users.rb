class AddInventoryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :inventory, :Item
  end
end
