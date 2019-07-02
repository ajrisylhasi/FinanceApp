class AddNormativesToExportProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :export_products, :normative, foreign_key: true
  end
end
