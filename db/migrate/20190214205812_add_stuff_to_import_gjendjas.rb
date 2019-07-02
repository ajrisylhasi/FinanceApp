class AddStuffToImportGjendjas < ActiveRecord::Migration[5.2]
  def change
    add_column :import_gjendjas, :sasia, :float
    add_column :import_gjendjas, :emertimi, :string
    add_column :import_gjendjas, :pershkrimi, :string
  end
end
