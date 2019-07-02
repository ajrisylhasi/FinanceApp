class AddQmimiToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :qmimi, :float
  end
end
