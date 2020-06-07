class AddVatToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :vat, :float
  end
end
