class CreateBabyProofingItems < ActiveRecord::Migration
  def change
    create_table :baby_proofing_items do |t|

      t.timestamps null: false
      t.integer :item_id
    end
  end
end
