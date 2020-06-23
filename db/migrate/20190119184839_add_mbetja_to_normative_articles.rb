class AddMbetjaToNormativeArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :normative_articles, :mbetja, :float
  end
end
