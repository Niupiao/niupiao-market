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
    end
  end
end
