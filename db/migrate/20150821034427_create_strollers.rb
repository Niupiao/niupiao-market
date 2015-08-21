class CreateStrollers < ActiveRecord::Migration
  def change
    create_table :strollers do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :fits
    end
  end
end
