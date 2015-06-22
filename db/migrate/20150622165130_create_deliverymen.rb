class CreateDeliverymen < ActiveRecord::Migration
  def change
    create_table :deliverymen do |t|
      t.text :name
      t.string :phone
      t.string :license
      t.text :bank_info
      t.float :amount_owed
      
      t.timestamps null: false
    end
  end
end
