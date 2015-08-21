class CreateNailPolishes < ActiveRecord::Migration
  def change
    create_table :nail_polishes do |t|
      t.integer :size
      t.text :color

      t.timestamps null: false
    end
  end
end
