class ChangeSasiaAtExportProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :export_products, :sasia, :integer
  end
end
