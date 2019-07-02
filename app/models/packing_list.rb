class PackingList < ApplicationRecord
  has_many :lists, dependent: :destroy
  # has_many :palet_lists, dependent: :destory
  belongs_to :export
  accepts_nested_attributes_for :lists, allow_destroy: true
  # accepts_nested_attributes_for :palet_lists, allow_destroy: true
  serialize :pack_gjendja
  
  before_save :default_values
  
  def default_values
    self.pack_gjendja ||= {}
  end
end
