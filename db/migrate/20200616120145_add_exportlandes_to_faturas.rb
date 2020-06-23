class AddExportlandesToFaturas < ActiveRecord::Migration[6.0]
  def change
    add_reference :faturas, :exportlande, foreign_key: true
  end
end
