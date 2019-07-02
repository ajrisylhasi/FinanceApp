class Product < ApplicationRecord
  has_many :normatives
  accepts_nested_attributes_for :normatives, allow_destroy: true
  has_many :export_products, dependent: :destroy
  has_many :exports, through: :export_products
  
  has_many :autorizim_products, dependent: :destroy
  has_many :autorizims, through: :autorizim_products
  
  has_many :product_packets, dependent: :destroy
  has_many :packets, through: :product_packets
  
  has_many :palet_products, dependent: :destroy
  has_many :palets, through: :palet_products
  
  def working_normatives
    self.normatives.select { |n| n.kategoria != "test" }
  end
end
