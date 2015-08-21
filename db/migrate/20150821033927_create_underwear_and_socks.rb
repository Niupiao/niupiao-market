class CreateUnderwearAndSocks < ActiveRecord::Migration
  def change
    create_table :underwear_and_socks do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :size
      t.integer :count
    end
  end
end
