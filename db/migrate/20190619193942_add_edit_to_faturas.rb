class AddEditToFaturas < ActiveRecord::Migration[5.2]
  def change
    add_column :faturas, :edit, :integer
  end
end
