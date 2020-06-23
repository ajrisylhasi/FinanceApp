class AddPeshaToExportGjendjas < ActiveRecord::Migration[5.2]
  def change
    add_column :export_gjendjas, :pesha, :float
    add_column :export_gjendjas, :mbetja_peshe, :float
  end
end
