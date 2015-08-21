class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.integer :size
      t.integer :count

      t.timestamps null: false
    end
  end
end
