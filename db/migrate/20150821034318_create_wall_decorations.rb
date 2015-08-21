class CreateWallDecorations < ActiveRecord::Migration
  def change
    create_table :wall_decorations do |t|

      t.timestamps null: false
      t.integer :item_id
      t.text :gender
    end
  end
end
