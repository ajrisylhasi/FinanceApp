class AddNdryshimiToExports < ActiveRecord::Migration[5.2]
  def change
    add_column :exports, :ndryshimi, :integer
  end
end
