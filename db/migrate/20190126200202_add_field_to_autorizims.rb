class AddFieldToAutorizims < ActiveRecord::Migration[5.2]
  def change
    add_column :autorizims, :data_leshimit, :date
    add_column :autorizims, :data_skadimit, :date
    add_column :autorizims, :shteti, :string
    add_column :autorizims, :qyteti, :string
    add_column :autorizims, :adresa, :string
  end
end
