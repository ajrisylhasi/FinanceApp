class AddImportToExplandeArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :explande_articles, :import, foreign_key: true
    add_reference :explande_articles, :import_article, foreign_key: true
  end
end
