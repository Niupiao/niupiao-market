class CreateLotionsAndCreams < ActiveRecord::Migration
  def change
    create_table :lotions_and_creams do |t|
      t.integer :size

      t.integer :item_id
      t.timestamps null: false
    end
  end
end
