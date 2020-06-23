class CreateProductPackets < ActiveRecord::Migration[5.2]
  def change
    create_table :product_packets do |t|
      t.references :product, foreign_key: true
      t.references :packet, foreign_key: true

      t.timestamps
    end
  end
end
