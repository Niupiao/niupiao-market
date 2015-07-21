class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :district
      t.string :committee
      t.string :street
      t.string :number
      t.timestamps null: false
    end
  end
end
