class AddTheStuffToImports < ActiveRecord::Migration[5.2]
  def change
    add_column :imports, :dogana, :string
    add_column :imports, :destinimi, :string
  end
end
