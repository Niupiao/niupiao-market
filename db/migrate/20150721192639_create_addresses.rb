class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :city
      t.string :district
      t.string :committee
      t.string :street
      t.string :door
      t.timestamps null: false
    end
  end
end
