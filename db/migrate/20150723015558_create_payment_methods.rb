class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.integer :user_id
      t.text :payment_type # Cash, Wire, Deposit, Card
      t.text :bank_account
      
      t.text :card_number
      t.text :cvv
      t.text :holder
      t.integer :exp_month
      t.integer :exp_year
      t.text :email
      t.timestamps null: false
    end
  end
end
