class AddClientToExports < ActiveRecord::Migration[5.2]
  def change
    add_reference :exports, :client, foreign_key: true
  end
end
