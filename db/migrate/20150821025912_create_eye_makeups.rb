class CreateEyeMakeups < ActiveRecord::Migration
  # Makeup/Beauty
  def change
    create_table :eye_makeups do |t|
      t.text :color

      t.integer :item_id
      t.timestamps null: false
    end
  end
end
