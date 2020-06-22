class Sub < ApplicationRecord
  belongs_to :import
  belongs_to :export
  belongs_to :import_gjendja
  belongs_to :export_gjendja
  has_one :sub_mbyllja
  
  after_save :default_values
  def default_values
    self.update_column(:mbetja_real, self.mbetja)
    self.update_column(:mbetja_qmimi_real, self.mbetja_qmimi)
    self.update_column(:mbetja_pesha_real, self.mbetja_peshe)
  end
  
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
      c = BigDecimal.new(pesha.to_s)
      a*c
    elsif self.import_gjendja.import_article.lloji_akcizes == "€/Njesi"
      a = BigDecimal.new(self.import_gjendja.import_article.akciza.to_s)
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
  
  #<======================================================>
  
  def mbetja_transport
    a = BigDecimal.new(self.mbetja_qmimi.to_s)
    b = BigDecimal.new(self.import_gjendja.import_article.qmimi.to_s)
    c = BigDecimal.new(self.import_gjendja.import_article.transport.to_s)
    a*c/b
  end
  
  def mbetja_qmimi_tot
    a = BigDecimal.new(self.mbetja_qmimi.to_s)
    b = BigDecimal.new(self.mbetja_transport.to_s)
    a + b
  end
  
  def mbetja_taksa_dogana
    a = BigDecimal.new(self.import_gjendja.import_article.dogana.to_s)
    b = BigDecimal.new(100.to_s)
    c = BigDecimal.new(self.mbetja_qmimi_tot.to_s)
    a*c/b
  end
  
  def mbetja_taksa_akciza
    if self.import_gjendja.import_article.lloji_akcizes == "Pa akcize"
      0
    elsif self.import_gjendja.import_article.lloji_akcizes == "%"
      a = BigDecimal.new(self.import_gjendja.import_article.akciza.to_s)
      c = BigDecimal.new(mbetja_qmimi_tot.to_s)
      d = BigDecimal.new(mbetja_taksa_dogana.to_s)
      a*(c+d)/b
    elsif self.import_gjendja.import_article.lloji_akcizes == "€/Kg"
      a = BigDecimal.new(self.import_gjendja.import_article.akciza.to_s)
      c = BigDecimal.new(mbetja_peshe.to_s)
      a*c
    elsif self.import_gjendja.import_article.lloji_akcizes == "€/Njesi"
      a = BigDecimal.new(self.import_gjendja.import_article.akciza.to_s)
      c = BigDecimal.new(mbetja.to_s)
      a*c
    end
  end
  
  def mbetja_taksa_tvsh
    a = BigDecimal.new(self.import_gjendja.import_article.tvsh.to_s)
    b = BigDecimal.new(100.to_s)
    c = BigDecimal.new(mbetja_qmimi_tot.to_s)
    d = BigDecimal.new(mbetja_taksa_akciza.to_s)
    e = BigDecimal.new(mbetja_taksa_dogana.to_s)
    a*(c+d+e)/b
  end
  
  def mbetja_gjithsej_taksa
    a = BigDecimal.new(self.mbetja_taksa_dogana.to_s)
    b = BigDecimal.new(self.mbetja_taksa_tvsh.to_s)
    c = BigDecimal.new(self.mbetja_taksa_akciza.to_s)
    a + b + c
  end
  
  def numri_im
    self.import.nr_dud
  end
  
  def emertimko
    self.import_gjendja.emertimi
  end
  
  def tarif_kodi
    self.import_gjendja.import_article.article.tarif_kodi
  end
  
  def kodi
    self.import_gjendja.kodi
  end
  
  def pershkrimi
    Article.where(kodi: self.import_gjendja.kodi).first.pershkrimi
  end
  
  def njesia
    Article.where(kodi: self.import_gjendja.kodi).first.njesia
  end
  
end
