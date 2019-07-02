class AddGjendjaHashToImports < ActiveRecord::Migration[5.2]
  def change
    add_column :imports, :gjendja_hash, :text
  end
end
