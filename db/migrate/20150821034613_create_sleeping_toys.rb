class CreateSleepingToys < ActiveRecord::Migration
  def change
    create_table :sleeping_toys do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
