class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :key, unique: true
      t.text :name
      t.text :email
      t.string :phone
      t.string :license
      t.text :bank_info
      t.float :amount_owed
      
      t.timestamps null: false
    end
  end
end
