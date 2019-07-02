class AddMbylljaToImports < ActiveRecord::Migration[5.2]
  def change
    add_reference :imports, :mbyllja, foreign_key: true
  end
end
