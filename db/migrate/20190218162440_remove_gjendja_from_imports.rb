class RemoveGjendjaFromImports < ActiveRecord::Migration[5.2]
  def change
    remove_column :imports, :gjendja, :text
  end
end
