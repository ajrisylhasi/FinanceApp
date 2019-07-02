class AddQmimiToExportGjendjas < ActiveRecord::Migration[5.2]
  def change
    add_column :export_gjendjas, :qmimi, :float
    add_column :export_gjendjas, :mbetja_qmimi, :float
  end
end
