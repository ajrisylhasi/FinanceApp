class CreateExportlandes < ActiveRecord::Migration[5.2]
  def change
    create_table :exportlandes do |t|

      t.timestamps
    end
  end
end
