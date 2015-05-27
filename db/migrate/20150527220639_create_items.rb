class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.name :string
      t.price :decimal
      t.text :tags

      t.timestamps
    end
  end
end
