class AddStuffToExport < ActiveRecord::Migration[5.2]
  def change
    add_column :exports, :data, :date
  end
end
