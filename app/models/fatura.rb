class Fatura < ApplicationRecord
  belongs_to :export, optional: true
  belongs_to :exportlande, optional: true
  has_many :fees, dependent: :destroy
  accepts_nested_attributes_for :fees, allow_destroy: true, reject_if: :all_blank
  

  before_save :pre

  def pre
    self.default ||= "Invoice"
  end
  
  def nr_faturess
    if self.export != nil
      exi = self.export.nr_exportit
    else 
      exi = self.exportlande.nr_exportit
    end
    fat = self.id
    exi = exi.gsub(" ", "")
    exi = exi.gsub("R", "")
    exi = exi.gsub("-", "")
    exi = exi.gsub("r", "")
    exi = exi.to_i
    if exi < 10
      exi = "000" + exi.to_s
    elsif exi < 100
      exi = "00" + exi.to_s
    elsif exi < 1000
      exi = "0" + exi.to_s
    end
    if fat < 10
      fat = "00" + fat.to_s
    elsif fat < 100
      fat = "0" + fat.to_s
    end
    "#{self.data.strftime("%Y")}-SHV01-#{exi}-#{fat}"
  end
end
