class AddPackGjendjaToPackingLists < ActiveRecord::Migration[5.2]
  def change
    add_column :packing_lists, :pack_gjendja, :text
  end
end
