class CreateGroomingHealthcareAndSkincares < ActiveRecord::Migration
  def change
    create_table :grooming_healthcare_and_skincares do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
