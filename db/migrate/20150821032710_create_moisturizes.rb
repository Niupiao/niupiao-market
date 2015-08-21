class CreateMoisturizes < ActiveRecord::Migration
  def change
    create_table :moisturizes do |t|
      t.integer :size
      t.text :color

      t.timestamps null: false
    end
  end
end
