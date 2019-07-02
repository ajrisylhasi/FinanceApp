class ProductPacket < ApplicationRecord
  belongs_to :product
  belongs_to :packet
  
  has_many :lists, dependent: :destroy
  
  def name
    "#{self.product.pershkrimi} - #{self.packet.dimensioni}"
  end
end
