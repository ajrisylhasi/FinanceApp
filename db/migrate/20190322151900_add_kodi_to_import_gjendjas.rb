class AddKodiToImportGjendjas < ActiveRecord::Migration[5.2]
  def change
    add_column :import_gjendjas, :kodi, :string
  end
end
