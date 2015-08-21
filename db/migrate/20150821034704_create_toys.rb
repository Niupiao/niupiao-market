class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
