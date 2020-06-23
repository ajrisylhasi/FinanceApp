class AddMbetjaToSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :mbetja, :float
  end
end
