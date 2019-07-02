class AddSomestuffToImports < ActiveRecord::Migration[5.2]
  def change
    add_column :imports, :kodi_doganor, :string
    add_column :imports, :zyra_doganore, :string
    add_column :imports, :kodi_destinim, :string
    add_column :imports, :zyra_destinim, :string
  end
end
