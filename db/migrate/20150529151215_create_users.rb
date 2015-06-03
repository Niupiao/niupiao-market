class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :first_name
      t.text :last_name
      t.text :email, unique: true
      t.text :password_digest
      t.text :address
      t.text :cart
      
      t.timestamps
    end
  end
end
