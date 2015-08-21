class CreateSpecialEffects < ActiveRecord::Migration
  def change
    create_table :special_effects do |t|
      t.integer :size
      t.integer :count

      t.timestamps null: false
    end
  end
end
