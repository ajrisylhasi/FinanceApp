class AddRealMbetjaTjeraToSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :mbetja_qmimi_real, :float
    add_column :subs, :mbetja_pesha_real, :float
  end
end
