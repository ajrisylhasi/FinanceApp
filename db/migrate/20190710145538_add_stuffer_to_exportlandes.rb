class AddStufferToExportlandes < ActiveRecord::Migration[5.2]
  def change
    add_column :exportlandes, :data, :date
  end
end
