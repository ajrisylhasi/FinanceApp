class AddFieldsToGarancions < ActiveRecord::Migration[5.2]
  def change
    add_column :garancions, :identifikimi, :string
    add_column :garancions, :vlera, :float
    add_column :garancions, :data, :date
    add_column :garancions, :data_skadimit, :date
    add_column :garancions, :pershkrimi, :string
  end
end
