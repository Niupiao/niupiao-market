class CreateGates < ActiveRecord::Migration
  def change
    create_table :gates do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :age
      t.integer :height
    end
  end
end
