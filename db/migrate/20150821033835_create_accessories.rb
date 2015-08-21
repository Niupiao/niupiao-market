class CreateAccessories < ActiveRecord::Migration
  def change
    create_table :accessories do |t|

      t.timestamps null: false
      t.integer :item_id
      t.text :style
      t.integer :count
    end
  end
end
