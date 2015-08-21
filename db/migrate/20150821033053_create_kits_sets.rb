class CreateKitsSets < ActiveRecord::Migration
  def change
    create_table :kits_sets do |t|
      t.integer :size

      t.integer :item_id
      t.timestamps null: false
    end
  end
end
