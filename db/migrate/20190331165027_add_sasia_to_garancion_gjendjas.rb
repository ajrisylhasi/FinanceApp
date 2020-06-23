class AddSasiaToGarancionGjendjas < ActiveRecord::Migration[5.2]
  def change
    add_column :garancion_gjendjas, :vlera, :float
  end
end
