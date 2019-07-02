class AddPackNotToExports < ActiveRecord::Migration[5.2]
  def change
    add_column :exports, :pack_not, :text
  end
end
