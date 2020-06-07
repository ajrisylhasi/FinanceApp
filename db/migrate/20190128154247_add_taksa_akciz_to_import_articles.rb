class AddTaksaAkcizToImportArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :import_articles, :taksa_akciza, :float
  end
end
