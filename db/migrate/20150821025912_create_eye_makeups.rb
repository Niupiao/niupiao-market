class CreateEyeMakeups < ActiveRecord::Migration
  def change
    create_table :eye_makeups do |t|
      t.text :color

      t.timestamps null: false
    end
  end
end
