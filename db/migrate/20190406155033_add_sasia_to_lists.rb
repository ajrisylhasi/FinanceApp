class AddSasiaToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :sasia, :integer
  end
end
