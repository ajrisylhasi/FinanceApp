class ChangeLimitToIntegers < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :tarif_kodi, :integer, :limit => 8
    change_column :products, :tarif_kodi, :integer, :limit => 8
  end
end
