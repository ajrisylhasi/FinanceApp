class AddQmimiToSubMbylljas < ActiveRecord::Migration[5.2]
  def change
    add_column :sub_mbylljas, :qmimi, :float
  end
end
