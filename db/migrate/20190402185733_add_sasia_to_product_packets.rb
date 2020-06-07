class AddSasiaToProductPackets < ActiveRecord::Migration[5.2]
  def change
    add_column :product_packets, :sasia, :integer
  end
end
