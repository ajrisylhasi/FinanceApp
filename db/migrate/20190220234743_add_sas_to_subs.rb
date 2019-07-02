class AddSasToSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :sasia, :float
  end
end
