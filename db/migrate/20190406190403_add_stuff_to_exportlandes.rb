class AddStuffToExportlandes < ActiveRecord::Migration[5.2]
  def change
    add_column :exportlandes, :nr_exportit, :string
    add_reference :exportlandes, :client, foreign_key: true
  end
end
