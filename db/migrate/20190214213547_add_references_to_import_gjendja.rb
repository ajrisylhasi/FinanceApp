class AddReferencesToImportGjendja < ActiveRecord::Migration[5.2]
  def change
    add_reference :import_gjendjas, :import, foreign_key: true
    add_reference :import_gjendjas, :import_article, foreign_key: true
  end
end
