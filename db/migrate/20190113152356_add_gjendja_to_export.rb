class AddGjendjaToExport < ActiveRecord::Migration[5.2]
  def change
    add_column :exports, :gjendja_hash, :text
  end
end
