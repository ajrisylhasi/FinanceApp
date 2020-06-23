class AddEmertimiToExplandeArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :explande_articles, :emertimi, :string
  end
end
