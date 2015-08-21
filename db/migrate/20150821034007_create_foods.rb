class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :volume
      t.integer :count
    end
  end
end
