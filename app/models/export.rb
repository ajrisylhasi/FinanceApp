class Export < ApplicationRecord
  belongs_to :client
  has_many :subs, dependent: :destroy
  has_many :imports, through: :subs
  has_many :export_products, dependent: :destroy
  has_many :products, through: :export_products
  accepts_nested_attributes_for :export_products, allow_destroy: true
  serialize :gjendja_hash
  serialize :pack_gjendja
  serialize :pack_not, Array
  has_many_attached :files
  
  has_many :export_gjendjas, dependent: :destroy
  has_one :packing_list, dependent: :destroy
  has_one :fatura, dependent: :destroy
  accepts_nested_attributes_for :fatura, allow_destroy: true
  
  before_save :default_values
  def default_values
    self.gjendja_hash ||= {}
    self.pack_gjendja ||= {}
    self.pack_not ||= []
    self.ndryshimi ||= 0
  end
  
  def pesha_b
    vlera = 0
    self.export_products.each do |a|
      vlera += a.normative.pesha_b * a.sasia
    end
    vlera
  end
  
  def pesha_n
    shuma = 0
    self.export_products.each do |a|
      shuma += a.normative.pesha_n * a.sasia
    end
    shuma
  end
end
