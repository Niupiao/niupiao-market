class CreateSkus < ActiveRecord::Migration
  def change
    create_table :skus do |t|
      t.text :category
      t.text :subcategory
      t.text :next_number

      t.timestamps null: false
    end
  end
end
