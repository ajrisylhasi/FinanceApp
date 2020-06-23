class AddPeshaToImportGjendjas < ActiveRecord::Migration[5.2]
  def change
    add_column :import_gjendjas, :pesha, :float
  end
end
