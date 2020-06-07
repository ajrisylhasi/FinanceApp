class AddGjendjaToImports < ActiveRecord::Migration[5.2]
  def change
    add_column :imports, :gjendja, :text
  end
end
