class AddKategoriaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :kategoria, :string
  end
end
