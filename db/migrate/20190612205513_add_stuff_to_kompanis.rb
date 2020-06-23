class AddStuffToKompanis < ActiveRecord::Migration[5.2]
  def change
    add_column :kompanis, :shteti, :string
    add_column :kompanis, :qyteti, :string
    add_column :kompanis, :adresa, :string
  end
end
