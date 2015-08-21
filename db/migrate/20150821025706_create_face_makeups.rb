class CreateFaceMakeups < ActiveRecord::Migration
  # Category: Makeup/Beauty
  def change
    create_table :face_makeups do |t|
      t.text :color
      t.integer :size
      
      t.integer :item_id
      t.timestamps null: false
    end
  end
end
