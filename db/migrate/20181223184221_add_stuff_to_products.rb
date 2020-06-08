class AddStuffToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :pershkrimi, :string
    add_column :products, :tarif_kodi, :integer, :limit => 8
  end
end
