class CreateLips < ActiveRecord::Migration
  def change
    create_table :lips do |t|

      t.timestamps null: false
    end
  end
end
