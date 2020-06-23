class AddMbetjaToExportGjendjas < ActiveRecord::Migration[5.2]
  def change
    add_column :export_gjendjas, :mbetja, :float
  end
end
