class AddRealMbetjaToSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :mbetja_real, :float
  end
end
