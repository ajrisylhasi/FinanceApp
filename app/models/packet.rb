class Packet < ApplicationRecord
  has_many :product_packets, dependent: :destroy
  has_many :products, through: :product_packets
  accepts_nested_attributes_for :product_packets, allow_destroy: true
  has_many_attached :files
  has_many :palet_packets, dependent: :destroy
  has_many :palets, through: :palet_packets
  
  def name
    "#{self.nr_paketes} - #{self.dimensioni}"
  end
end
