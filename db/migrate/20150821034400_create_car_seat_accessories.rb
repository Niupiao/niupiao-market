class CreateCarSeatAccessories < ActiveRecord::Migration
  def change
    create_table :car_seat_accessories do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
