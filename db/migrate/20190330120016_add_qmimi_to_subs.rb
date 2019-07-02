class AddQmimiToSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :qmimi, :float
    add_column :subs, :mbetja_qmimi, :float
  end
end
