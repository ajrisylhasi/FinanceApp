class AddArticlenrToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :articlenr, :string
  end
end
