class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.text :item_name
      t.text :item_tags
      t.text :seller_name
      t.integer :seller_id
      t.float :charge
      t.timestamps null: false
    end
  end
end
