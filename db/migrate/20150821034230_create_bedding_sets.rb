class CreateBeddingSets < ActiveRecord::Migration
  def change
    create_table :bedding_sets do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :pieces
    end
  end
end
