class CreatePackets < ActiveRecord::Migration[5.2]
  def change
    create_table :packets do |t|
      t.string :nr_paketes
      t.string :dimensioni

      t.timestamps
    end
  end
end
