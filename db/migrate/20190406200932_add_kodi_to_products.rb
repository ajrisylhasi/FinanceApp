class AddKodiToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :kodi, :string
  end
end
