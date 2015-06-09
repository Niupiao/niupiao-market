class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user
      t.text :name
      t.text :type
      t.float :price
      t.integer :quantity
      t.text :desc
    end
  end
end
