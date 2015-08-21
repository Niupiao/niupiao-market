class CreateStylingProductsAndTools < ActiveRecord::Migration
  def change
    create_table :styling_products_and_tools do |t|
      t.integer :size

      t.timestamps null: false
    end
  end
end
