class ChangeLlojiFromImportArticles < ActiveRecord::Migration[5.2]
  def change
    change_column :import_articles, :lloji_akcizes, :string
  end
end
