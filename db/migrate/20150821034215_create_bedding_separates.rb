class CreateBeddingSeparates < ActiveRecord::Migration
  def change
    create_table :bedding_separates do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
