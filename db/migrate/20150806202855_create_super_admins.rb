class CreateSuperAdmins < ActiveRecord::Migration
  def change
    create_table :super_admins do |t|
      
      t.string :username
      t.text :password_digest
      t.timestamps null: false
    end
  end
end
