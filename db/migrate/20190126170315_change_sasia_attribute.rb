class ChangeSasiaAttribute < ActiveRecord::Migration[5.2]
  def change
    rename_column :import_articles, :sasia_kg, :sasia
    rename_column :normative_articles, :sasia_kg, :sasia
  end
end
