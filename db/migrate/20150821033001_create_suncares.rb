class CreateSuncares < ActiveRecord::Migration
  def change
    create_table :suncares do |t|
      t.integer :size
      t.text :color

      t.timestamps null: false
    end
  end
end
