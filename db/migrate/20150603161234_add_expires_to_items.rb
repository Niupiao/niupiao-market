class AddExpiresToItems < ActiveRecord::Migration
  def change
    add_column :items, :expires, :Date
  end
end
