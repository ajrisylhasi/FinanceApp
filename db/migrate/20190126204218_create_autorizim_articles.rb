class CreateAutorizimArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :autorizim_articles do |t|
      t.references :article, foreign_key: true
      t.references :autorizim, foreign_key: true

      t.timestamps
    end
  end
end
