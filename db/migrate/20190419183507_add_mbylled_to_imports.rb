class AddMbylledToImports < ActiveRecord::Migration[5.2]
  def change
    add_column :imports, :mbylled, :boolean
  end
end
