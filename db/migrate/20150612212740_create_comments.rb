class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :item
      t.text :body
      t.integer :rating
      t.timestamps null: false
    end
  end
end
