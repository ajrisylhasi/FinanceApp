class CreateExportProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :export_products do |t|
      t.references :export, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
