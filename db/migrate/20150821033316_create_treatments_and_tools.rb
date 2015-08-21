class CreateTreatmentsAndTools < ActiveRecord::Migration
  def change
    create_table :treatments_and_tools do |t|

      t.timestamps null: false
    end
  end
end
