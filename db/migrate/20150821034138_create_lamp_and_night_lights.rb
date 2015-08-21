class CreateLampAndNightLights < ActiveRecord::Migration
  def change
    create_table :lamp_and_night_lights do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
