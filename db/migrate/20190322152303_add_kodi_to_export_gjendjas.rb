class AddKodiToExportGjendjas < ActiveRecord::Migration[5.2]
  def change
    add_column :export_gjendjas, :kodi, :string
  end
end
