class CreateNormativeArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :normative_articles do |t|
      t.references :normative, foreign_key: true
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
