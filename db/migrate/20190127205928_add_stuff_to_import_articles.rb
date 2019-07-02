class AddStuffToImportArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :import_articles, :emertimi, :string
    add_column :import_articles, :pesha, :float
    add_column :import_articles, :qmimi, :float
    add_column :import_articles, :qmimi_tot, :float
    add_column :import_articles, :transport, :float
    add_column :import_articles, :pesha_njesi, :float
    add_column :import_articles, :qmimi_njesi, :float
    add_column :import_articles, :qmimi_kg, :float
    add_column :import_articles, :dogana, :float
    add_column :import_articles, :taksa_dogana, :float
    add_column :import_articles, :lloji_akcizes, :float
    add_column :import_articles, :akciza, :float
    add_column :import_articles, :tvsh, :float
    add_column :import_articles, :taksa_tvsh, :float
    add_column :import_articles, :gjithsej_taksa, :float
  end
end
