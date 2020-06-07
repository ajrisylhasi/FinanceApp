class CreateExportGjendjas < ActiveRecord::Migration[5.2]
  def change
    create_table :export_gjendjas do |t|
      t.references :export, foreign_key: true
      t.float :sasia
      t.string :pershkrimi
      t.references :export_product, foreign_key: true

      t.timestamps
    end
  end
end
