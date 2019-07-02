class AddSasiaToExportProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :export_products, :sasia, :float
  end
end
