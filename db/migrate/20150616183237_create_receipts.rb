class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.references :user
      t.text :item_name
      t.integer :item_quantity
      t.text :item_tags
      t.text :item_type
      t.text :seller_name
      t.integer :seller_id
      t.float :charge
      t.timestamps null: false
    end
  end
end
