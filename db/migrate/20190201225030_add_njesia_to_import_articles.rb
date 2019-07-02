class AddNjesiaToImportArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :import_articles, :njesia, :string
  end
end
