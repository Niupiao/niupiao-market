class CreateToolsAndBags < ActiveRecord::Migration
  def change
    create_table :tools_and_bags do |t|

      t.timestamps null: false
    end
  end
end
