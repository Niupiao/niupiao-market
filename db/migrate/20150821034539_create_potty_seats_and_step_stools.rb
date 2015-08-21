class CreatePottySeatsAndStepStools < ActiveRecord::Migration
  def change
    create_table :potty_seats_and_step_stools do |t|

      t.timestamps null: false
      t.integer :item_id
      
    end
  end
end
