class AddDataImpToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :data_imp, :integer
  end
end
