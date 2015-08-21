class CreateShowerAndBaths < ActiveRecord::Migration
  def change
    create_table :shower_and_baths do |t|
      t.integer :size

      t.integer :item_id
      t.timestamps null: false
    end
  end
end
