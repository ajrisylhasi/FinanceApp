class AddQmimiToImportGjendjas < ActiveRecord::Migration[5.2]
  def change
    add_column :import_gjendjas, :qmimi, :float
  end
end
