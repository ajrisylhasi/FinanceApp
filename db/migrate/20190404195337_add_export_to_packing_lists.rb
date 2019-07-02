class AddExportToPackingLists < ActiveRecord::Migration[5.2]
  def change
    add_reference :packing_lists, :export, foreign_key: true
  end
end
