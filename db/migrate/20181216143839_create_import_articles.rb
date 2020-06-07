class CreateImportArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :import_articles do |t|
      t.references :import, foreign_key: true
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
