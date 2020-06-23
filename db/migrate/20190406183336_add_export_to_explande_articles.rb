class AddExportToExplandeArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :explande_articles, :exportlande, foreign_key: true
  end
end
