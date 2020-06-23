class AddZipToKompanis < ActiveRecord::Migration[5.2]
  def change
    add_column :kompanis, :zip, :string
  end
end
