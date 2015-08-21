class CreateGirlsClothings < ActiveRecord::Migration
  def change
    create_table :girls_clothings do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :size
      t.text :style
    end
  end
end
