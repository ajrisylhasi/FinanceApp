class AddClientIndexToImports < ActiveRecord::Migration[5.2]
  def change
    add_reference :imports, :client, foreign_key: true
  end
end
