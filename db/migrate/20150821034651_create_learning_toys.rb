class CreateLearningToys < ActiveRecord::Migration
  def change
    create_table :learning_toys do |t|

      t.timestamps null: false
      t.integer :item_id
      t.integer :age
    end
  end
end
