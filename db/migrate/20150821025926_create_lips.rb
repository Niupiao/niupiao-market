class CreateLips < ActiveRecord::Migration
  def change
    create_table :lips do |t|

      t.integer :item_id
      t.timestamps null: false
    end
  end
end
