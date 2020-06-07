class AddArticleToExplandeArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :explande_articles, :article, foreign_key: true
  end
end
