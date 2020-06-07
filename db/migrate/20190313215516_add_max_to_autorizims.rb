class AddMaxToAutorizims < ActiveRecord::Migration[5.2]
  def change
    add_column :autorizims, :max, :float
  end
end
