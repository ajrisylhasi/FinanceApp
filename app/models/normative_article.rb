class NormativeArticle < ApplicationRecord
  belongs_to :normative
  belongs_to :article
  
  validates :sasia, presence: true
  validates :pesha_qmimi, presence: true, if: :auto?
  validates :pesha_bruto, presence: true, if: :manual?
  
  def auto?
    self.normative.kategoria == "auto"
  end
  
  def manual?
    self.normative.kategoria == "manual" || self.normative.kategoria == "test"
  end
  
  before_save :pre_values
  after_save :default_values
  after_save :default_values_auto, if: :auto?
  
  def pre_values
    self.mbetja ||= 0
    self.mbetja_peshe ||= 0
  end
  
  def default_values
    update_column(:njesia, self.article.njesia)
  end
  
  def default_values_auto
    
    dyjat = self.pesha_qmimi.split
    psh = BigDecimal.new(dyjat[0])
    update_column(:pesha_bruto, psh * self.sasia)
  end
  
  def sasia_neto
    a = BigDecimal.new(self.sasia.to_s)
    b = BigDecimal.new(self.mbetja.to_s)
    c = BigDecimal.new(100.to_s)  
    a - (b*a/c)
  end
  
  def pesha_neto
    a = BigDecimal.new(self.pesha_bruto.to_s)
    b = BigDecimal.new(self.mbetja_peshe.to_s)
    c = BigDecimal.new(100.to_s)
    a - (b*a/c)
  end
  
  def mbetja_ne_peshe
    a = BigDecimal.new(self.mbetja_peshe.to_s)
    b = BigDecimal.new(100.to_s)
    c = BigDecimal.new(self.pesha_bruto.to_s)
    a * c / b 
  end
  
  def mbetja_ne_sasi
    a = BigDecimal.new(self.mbetja.to_s)
    b = BigDecimal.new(100.to_s)
    c = BigDecimal.new(self.sasia.to_s)
    a * c / b 
  end
end
