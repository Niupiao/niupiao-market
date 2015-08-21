class CreateGymsAndPlaymats < ActiveRecord::Migration
  def change
    create_table :gyms_and_playmats do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
