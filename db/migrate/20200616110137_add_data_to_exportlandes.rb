class AddDataToExportlandes < ActiveRecord::Migration[6.0]
  def change
    add_column :exportlandes, :data, :date
  end
end
