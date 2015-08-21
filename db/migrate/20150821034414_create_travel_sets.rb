class CreateTravelSets < ActiveRecord::Migration
  def change
    create_table :travel_sets do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
