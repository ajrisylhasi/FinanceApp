class AddNormativeArticlesToExportGjendjas < ActiveRecord::Migration[5.2]
  def change
    add_reference :export_gjendjas, :normative_article, foreign_key: true
  end
end
