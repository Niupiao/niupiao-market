class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :first_name
      t.text :last_name
      t.text :email, unique: true
      t.text :password_digest
      t.text :cart
      t.string :phone
      
      t.integer :address_id
      
      t.text :provider
      t.text :uid, unique: true
      t.text :oauth_token
      t.text :oauth_expires_at
      
      t.timestamps
    end
  end
end
