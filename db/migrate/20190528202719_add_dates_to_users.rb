class AddDatesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :data_auto, :integer
    add_column :users, :data_gar, :integer
  end
end
