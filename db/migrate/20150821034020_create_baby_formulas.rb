class CreateBabyFormulas < ActiveRecord::Migration
  def change
    create_table :baby_formulas do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :volume
      t.integer :count
      t.integer :age
    end
  end
end
