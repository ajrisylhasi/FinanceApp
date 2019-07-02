class AddStuffToExplandeArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :explande_articles, :pesha, :float
    add_column :explande_articles, :qmimi, :float
  end
end
