class AddFaturaToImports < ActiveRecord::Migration[5.2]
  def change
    add_column :imports, :nr_fatures, :string
  end
end
