class Subexpl < ApplicationRecord
  belongs_to :import
  belongs_to :exportlande
  belongs_to :import_gjendja
  belongs_to :explande_article
  
  def transport
    a = BigDecimal.new(self.qmimi.to_s)
    b = BigDecimal.new(self.import_gjendja.import_article.qmimi.to_s)
    c = BigDecimal.new(self.import_gjendja.import_article.transport.to_s)
    a*c/b
  end
  
  def qmimi_tot
    a = BigDecimal.new(self.qmimi.to_s)
    b = BigDecimal.new(self.transport.to_s)
    a + b
  end
  
  def taksa_dogana
    a = BigDecimal.new(self.import_gjendja.import_article.dogana.to_s)
    b = BigDecimal.new(100.to_s)
    c = BigDecimal.new(self.qmimi_tot.to_s)
    a*c/b
  end
  
  def taksa_akciza
    if self.import_gjendja.import_article.lloji_akcizes == "Pa akcize"
      0
    elsif self.import_gjendja.import_article.lloji_akcizes == "%"
      a = BigDecimal.new(self.import_gjendja.import_article.akciza.to_s)
      b = BigDecimal.new(100.to_s)
      c = BigDecimal.new(qmimi_tot.to_s)
      d = BigDecimal.new(self.taksa_dogana.to_s)
      a*c(+d)/b
    elsif self.import_gjendja.import_article.lloji_akcizes == "€/Kg"
      a = BigDecimal.new(self.import_gjendja.import_article.akciza.to_s)
      b = BigDecimal.new(100.to_s)
      c = BigDecimal.new(pesha.to_s)
      a*c
    elsif self.import_gjendja.import_article.lloji_akcizes == "€/Njesi"
      a = BigDecimal.new(self.import_gjendja.import_article.akciza.to_s)
      b = BigDecimal.new(100.to_s)
      c = BigDecimal.new(sasia.to_s)
      a*c
    end
  end
  
  def taksa_tvsh
    a = BigDecimal.new(self.import_gjendja.import_article.tvsh.to_s)
    b = BigDecimal.new(100.to_s)
    c = BigDecimal.new(qmimi_tot.to_s)
    d = BigDecimal.new(taksa_akciza.to_s)
    e = BigDecimal.new(taksa_dogana.to_s)
    a*(c+d+e)/b
  end
  
  def gjithsej_taksa
    a = BigDecimal.new(self.taksa_dogana.to_s)
    b = BigDecimal.new(self.taksa_tvsh.to_s)
    c = BigDecimal.new(self.taksa_akciza.to_s)
    a + b + c
  end
  
  #<====================================>
  def mbetja_transport
    0
  end
  
  def mbetja_qmimi_tot
    0
  end
  
  def mbetja_taksa_dogana
    0
  end
  
  def mbetja_taksa_akciza
    0
  end
  
  def mbetja_taksa_tvsh
    0
  end
  
  def mbetja_gjithsej_taksa
    0
  end
end
