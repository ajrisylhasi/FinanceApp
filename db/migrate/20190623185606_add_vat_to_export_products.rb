class AddVatToExportProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :export_products, :vat, :float
  end
end
