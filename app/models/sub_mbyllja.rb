class SubMbyllja < ApplicationRecord
  belongs_to :sub
  belongs_to :mbyllja
  	
  def i
    self.sub.import_gjendja.import_article
  end

  def e
    self.sub.export
  end
  
  def transport
    a = BigDecimal.new(self.qmimi.to_s)
    b = BigDecimal.new(i.qmimi.to_s)
    c = BigDecimal.new(i.transport.to_s)
    a*c/b
  end

  def qmimi_tot
    a = BigDecimal.new(self.qmimi.to_s)
    b = BigDecimal.new(self.transport.to_s)
    a + b
  end
  
  def taksa_dogana
    a = BigDecimal.new(i.dogana.to_s)
    b = BigDecimal.new(100.to_s)
    c = BigDecimal.new(self.qmimi_tot.to_s)
    a*c/b
  end
  
  def taksa_akciza
    if i.lloji_akcizes == "Pa akcize"
      0
    elsif i.lloji_akcizes == "%"
      a = BigDecimal.new(i.akciza.to_s)
      b = BigDecimal.new(100.to_s)
      c = BigDecimal.new(qmimi_tot.to_s)
      d = BigDecimal.new(self.taksa_dogana.to_s)
      a*c(+d)/b
    elsif i.lloji_akcizes == "€/Kg"
      a = BigDecimal.new(i.akciza.to_s)
      b = BigDecimal.new(100.to_s)
      c = BigDecimal.new(pesha.to_s)
      a*c/b
    elsif i.lloji_akcizes == "€/Njesi"
      a = BigDecimal.new(i.akciza.to_s)
      b = BigDecimal.new(100.to_s)
      c = BigDecimal.new(sasia.to_s)
      a*c/b
    end
  end
  
  def taksa_tvsh
    a = BigDecimal.new(i.tvsh.to_s)
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
end
