class CreateMen < ActiveRecord::Migration
  def change
    create_table :men do |t|
      t.integer :size

      t.integer :item_id
      t.timestamps null: false
    end
  end
end
