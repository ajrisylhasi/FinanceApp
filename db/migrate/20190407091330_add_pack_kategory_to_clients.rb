class AddPackKategoryToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :pack_category, :string
  end
end
