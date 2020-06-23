class AddTermToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :term, :integer
  end
end
