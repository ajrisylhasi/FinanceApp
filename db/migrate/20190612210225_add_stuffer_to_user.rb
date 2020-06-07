class AddStufferToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_column :users, :tel_number, :string
  end
end
