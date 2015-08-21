class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user
      t.text :name
      t.text :item_type
      t.text :tags
      t.float :price
      t.integer :quantity
      t.text :desc
      
      t.integer :supercategory_id
      t.integer :category_id
      
      t.integer :subitem_id
      t.text :subitem_type
    end
  end
end
