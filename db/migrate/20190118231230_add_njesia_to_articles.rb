class AddNjesiaToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :njesia, :string
  end
end
