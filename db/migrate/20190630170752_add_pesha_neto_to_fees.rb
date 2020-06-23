class AddPeshaNetoToFees < ActiveRecord::Migration[5.2]
  def change
    add_column :fees, :pesha_neto, :float
  end
end
