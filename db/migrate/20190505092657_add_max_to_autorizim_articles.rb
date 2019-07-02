class AddMaxToAutorizimArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :autorizim_articles, :max, :float
  end
end
