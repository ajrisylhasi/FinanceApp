class AddVleraTToGarancions < ActiveRecord::Migration[5.2]
  def change
    add_column :garancions, :vlera_t, :float
  end
end
