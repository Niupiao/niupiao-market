class CreateBabyMonitors < ActiveRecord::Migration
  def change
    create_table :baby_monitors do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
