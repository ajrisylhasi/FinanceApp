class AddPacketsToLists < ActiveRecord::Migration[5.2]
  def change
    add_reference :lists, :packet, foreign_key: true
  end
end
