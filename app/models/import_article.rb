class ImportArticle < ApplicationRecord
  
  belongs_to :import
  belongs_to :article
  
  has_many :explande_articles
  has_one :import_gjendja, dependent: :destroy
  
  
  validates :sasia, presence: true
  validates :qmimi, presence: true
  validates :pesha, presence: true
  after_save :default_values
  
  def default_values
    update_column(:lloji_akcizes, self.article.lloji_akcizes)
    update_column(:dogana, self.article.dogana)
    update_column(:akciza, self.article.akciza)
    update_column(:tvsh, self.article.tvsh)
    update_column(:njesia, self.article.njesia)
    update_column(:kodi, self.article.kodi)
  end
  
  def transport
    a = BigDecimal.new(self.qmimi.to_s)
    b = BigDecimal.new(self.import.import_articles.sum(:qmimi).to_s)
    c = BigDecimal.new(self.import.transporti.to_s)
    a*c/b
  end
  
  def pesha_njesi
    a = BigDecimal.new(self.pesha.to_s)
    b = BigDecimal.new(self.sasia.to_s)
    a/b
  end
  
  def qmimi_tot
    a = BigDecimal.new(self.qmimi.to_s)
    b = BigDecimal.new(self.transport.to_s)
    a + b
  end
  
  def qmimi_njesi_norm
    a = BigDecimal.new(self.qmimi.to_s)
    b = BigDecimal.new(self.sasia.to_s)
    a/b
  end
  
  def qmimi_njesi
    a = BigDecimal.new(self.qmimi_tot.to_s)
    b = BigDecimal.new(self.sasia.to_s)
    a/b
  end
  
  def qmimi_kg
    a = BigDecimal.new(self.qmimi_tot.to_s)
    b = BigDecimal.new(self.pesha.to_s)
    a/b
  end
  
  def taksa_dogana
    a = BigDecimal.new(self.dogana.to_s)
    b = BigDecimal.new(100.to_s)
    c = BigDecimal.new(self.qmimi_tot.to_s)
    a*c/b 
  end
  
  def taksa_akciza
    if self.lloji_akcizes == "Pa akcize"
      self.taksa_akciza = 0
    elsif self.lloji_akcizes == "%"
      a = BigDecimal.new(self.akciza.to_s)
      c = BigDecimal.new(qmimi_tot.to_s)
      d = BigDecimal.new(self.taksa_dogana.to_s)
      self.taksa_akciza = a*(c+d)/b
    elsif self.lloji_akcizes == "€/Kg"
      a = BigDecimal.new(self.akciza.to_s)
      c = BigDecimal.new(pesha.to_s)
      self.taksa_akciza = a*c
    elsif self.lloji_akcizes == "€/Njesi"
      a = BigDecimal.new(self.akciza.to_s)
      c = BigDecimal.new(sasia.to_s)
      self.taksa_akciza = a*c
    end
  end
  
  def taksa_tvsh
    a = BigDecimal.new(self.tvsh.to_s)
    b = BigDecimal.new(100.to_s)
    c = BigDecimal.new(qmimi_tot.to_s)
    d = BigDecimal.new(taksa_akciza.to_s)
    e = BigDecimal.new(taksa_dogana.to_s)
    a*(c + d + e)/b
  end
  
  def gjithsej_taksa
    a = BigDecimal.new(self.taksa_dogana.to_s)
    b = BigDecimal.new(self.taksa_tvsh.to_s)
    c = BigDecimal.new(self.taksa_akciza.to_s)
    a + b + c
  end
  
  
  def show_text
    "#{pesha_njesi} Kg/#{self.article.njesia} - Importi: #{self.import.nr_dud}"
  end
  
  def show_text_exp
    "#{self.article.pershkrimi} (#{self.article.kodi}) - Emertimi: #{self.emertimi}"
  end
  
  def show_text_search
    "#{self.article.pershkrimi} (#{self.article.kodi})"
  end
  
  def grupi
    a = BigDecimal.new(pesha_njesi.to_s)
    b = BigDecimal.new(qmimi_njesi_norm.to_s)
    "#{a} #{b}"
  end
  
  
end
