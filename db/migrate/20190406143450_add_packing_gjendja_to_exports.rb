class AddPackingGjendjaToExports < ActiveRecord::Migration[5.2]
  def change
    add_column :exports, :pack_gjendja, :text
  end
end
