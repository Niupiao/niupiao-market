class CreateBoosterSeats < ActiveRecord::Migration
  def change
    create_table :booster_seats do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
