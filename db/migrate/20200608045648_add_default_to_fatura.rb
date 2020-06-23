class AddDefaultToFatura < ActiveRecord::Migration[6.0]
  def change
    add_column :faturas, :default, :string
  end
end
