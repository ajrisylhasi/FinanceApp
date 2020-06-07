class AddImportGjendjasToSubs < ActiveRecord::Migration[5.2]
  def change
    add_reference :subs, :import_gjendja, foreign_key: true
    add_reference :subs, :export_gjendja, foreign_key: true
  end
end
