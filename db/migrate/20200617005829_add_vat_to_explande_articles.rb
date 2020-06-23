class AddVatToExplandeArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :explande_articles, :vat, :float
  end
end
