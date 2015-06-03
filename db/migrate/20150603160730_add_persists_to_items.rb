class AddPersistsToItems < ActiveRecord::Migration
  def change
    add_column :items, :persists, :boolean
  end
end
