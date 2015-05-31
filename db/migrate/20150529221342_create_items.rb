class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user
      t.string :name
      t.float :price
      t.integer :quantity
      t.string :desc
    end
  end
end
