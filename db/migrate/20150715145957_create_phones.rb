class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.text :manufacturer
      t.text :origin
      t.integer :best
      t.integer :item_id

      t.timestamps null: false
    end
  end
end