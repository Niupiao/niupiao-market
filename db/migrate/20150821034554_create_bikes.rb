class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
