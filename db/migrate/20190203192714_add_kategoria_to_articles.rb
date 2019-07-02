class AddKategoriaToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :kategoria, :string
  end
end
