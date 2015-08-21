class CreateShampooAndConditioners < ActiveRecord::Migration
  def change
    create_table :shampoo_and_conditioners do |t|
      t.integer :size

      t.integer :item_id
      t.timestamps null: false
    end
  end
end
