class CreateBoosterCarSeats < ActiveRecord::Migration
  def change
    create_table :booster_car_seats do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :child_weight
    end
  end
end
