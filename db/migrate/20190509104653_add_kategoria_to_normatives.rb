class AddKategoriaToNormatives < ActiveRecord::Migration[5.2]
  def change
    add_column :normatives, :kategoria, :string
  end
end
