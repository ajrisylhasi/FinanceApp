class AddNrToExports < ActiveRecord::Migration[5.2]
  def change
    add_column :exports, :nr_exportit, :string
  end
end
