class CreatePalets < ActiveRecord::Migration[5.2]
  def change
    create_table :palets do |t|
      t.string :nr_paletes
      t.string :dimensioni

      t.timestamps
    end
  end
end
