class AddKodiToImportArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :import_articles, :kodi, :string
  end
end
