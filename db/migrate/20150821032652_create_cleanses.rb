class CreateCleanses < ActiveRecord::Migration
  def change
    create_table :cleanses do |t|
      t.integer :size

      t.integer :item_id
      t.timestamps null: false
    end
  end
end
