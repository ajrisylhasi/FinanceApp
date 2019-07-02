class AddStuffToNormativeArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :normative_articles, :njesia, :string
    add_column :normative_articles, :pesha_bruto, :float
    add_column :normative_articles, :mbetja_peshe, :float
  end
end
