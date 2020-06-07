class AddFieldsToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :kodi, :string
    add_column :articles, :pershkrimi_gjate, :text
    add_column :articles, :dogana, :float
    add_column :articles, :lloji_akcizes, :string
    add_column :articles, :akciza, :float
    add_column :articles, :tvsh, :float
  end
end
