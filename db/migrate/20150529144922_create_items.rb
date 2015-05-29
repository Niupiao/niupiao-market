class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :owner
      t.string :name
      t.float :price
      t.integer :quantity
      t.string :desc
    end
  end
end
