class AddSasiakgToImportArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :import_articles, :sasia_kg, :float
  end
end
