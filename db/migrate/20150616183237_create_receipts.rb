class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.references :buyer
      t.references :seller
      t.text :item_name
      t.integer :item_quantity
      t.text :item_tags
      t.text :item_type
      t.string :status # Order Sent -> Paid For -> In Transit -> Delivered -> Complete
      t.text :checkin_code # Allows non-logged in users to check status of their receipt
      t.text :seller_availability # Available times seller can drop off item
      t.text :buyer_availability # Available times buyer can drop off item.
      t.text :delivery_instruction
      t.float :charge
      t.timestamps null: false
    end
  end
end
