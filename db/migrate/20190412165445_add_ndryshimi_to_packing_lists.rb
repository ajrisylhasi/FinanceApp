class AddNdryshimiToPackingLists < ActiveRecord::Migration[5.2]
  def change
    add_column :packing_lists, :ndryshimi, :integer
  end
end
