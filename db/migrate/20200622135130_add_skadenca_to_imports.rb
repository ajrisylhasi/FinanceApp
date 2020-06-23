class AddSkadencaToImports < ActiveRecord::Migration[6.0]
  def change
    add_column :imports, :data_skadimit, :date
  end
end
