class Palet < ApplicationRecord
  has_many_attached :files
  has_many :palet_products, dependent: :destroy
  has_many :products, through: :palet_products
  accepts_nested_attributes_for :palet_products, allow_destroy: true
  has_many :palet_packets, dependent: :destroy
  has_many :packets, through: :palet_packets
  accepts_nested_attributes_for :palet_packets, allow_destroy: true
end
