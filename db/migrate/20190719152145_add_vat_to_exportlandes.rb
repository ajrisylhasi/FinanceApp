class AddVatToExportlandes < ActiveRecord::Migration[5.2]
  def change
    add_column :exportlandes, :vat, :float
  end
end
