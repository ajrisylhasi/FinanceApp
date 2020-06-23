class AddPeshaToSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :pesha, :float
    add_column :subs, :mbetja_peshe, :float
  end
end
