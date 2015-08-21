class CreateSupercategories < ActiveRecord::Migration
  def change
    create_table :supercategories do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
