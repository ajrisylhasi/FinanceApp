class AddSasiaToExplandeArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :explande_articles, :sasia, :float
  end
end
