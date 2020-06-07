class CreatePaletPackets < ActiveRecord::Migration[5.2]
  def change
    create_table :palet_packets do |t|
      t.references :palet, foreign_key: true
      t.references :packet, foreign_key: true
      t.integer :sasia

      t.timestamps
    end
  end
end
