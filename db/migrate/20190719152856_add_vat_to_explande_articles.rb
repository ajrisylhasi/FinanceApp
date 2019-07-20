class AddVatToExplandeArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :explande_articles, :vat, :float
  end
end
