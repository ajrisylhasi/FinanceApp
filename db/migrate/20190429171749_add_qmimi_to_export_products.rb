class AddQmimiToExportProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :export_products, :qmimi, :float
  end
end
