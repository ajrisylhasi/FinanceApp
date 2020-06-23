class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.references :product_packet, foreign_key: true
      t.references :packing_list, foreign_key: true

      t.timestamps
    end
  end
end
