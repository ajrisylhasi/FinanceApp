class AddSasiaToNormativeArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :normative_articles, :sasia_kg, :float
  end
end
