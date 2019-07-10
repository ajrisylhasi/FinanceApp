class AddDefaultToFaturas < ActiveRecord::Migration[5.2]
  def change
    add_column :faturas, :default, :string
  end
end
