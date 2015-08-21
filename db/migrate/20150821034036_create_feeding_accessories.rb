class CreateFeedingAccessories < ActiveRecord::Migration
  def change
    create_table :feeding_accessories do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :count
    end
  end
end
