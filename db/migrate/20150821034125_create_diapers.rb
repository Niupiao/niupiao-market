class CreateDiapers < ActiveRecord::Migration
  def change
    create_table :diapers do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :size
      t.integer :count
    end
  end
end
