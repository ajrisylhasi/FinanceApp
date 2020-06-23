class Import < ApplicationRecord
  has_many :import_articles, dependent: :destroy
  has_many :articles, through: :import_articles
  accepts_nested_attributes_for :import_articles, allow_destroy: true
  
  has_many :subs, dependent: :destroy
  has_many :exports, through: :subs
  
  belongs_to :client
  belongs_to :mbyllja, optional: true
  
  has_many_attached :files
  
  serialize :gjendja_hash
  
  has_many :import_gjendjas, dependent: :destroy
  
  has_many :explande_articles
  
  validates :nr_dud, presence: true, uniqueness: true
  validates :dogana, presence: true
  validates :data, presence: true
  validates :data_skadimit, presence: true
  validates :destinimi, presence: true
  
  before_save :default_values
  def default_values
    self.gjendja_hash ||= {} 
    self.mbylled ||= false
  end
  
  after_save :after_values
  
  def after_values
    dyjat = self.dogana.split("=*=")
    kodi_doganor = dyjat[0]
    zyra_doganore = dyjat[1]
    dy_qerat = self.destinimi.split("=*=")
    kodi_destinim = dy_qerat[0]
    zyra_destinim = dy_qerat[1]
    update_column(:kodi_destinim, kodi_destinim)
    update_column(:kodi_doganor, kodi_doganor)
    update_column(:zyra_destinim, zyra_destinim)
    update_column(:zyra_doganore, zyra_doganore)
  end
  
  def prezantim
    "#{self.nr_dud} (#{self.data.strftime("%d/%m/%Y")})"
  end
  
  def taksa
    t = 0
    self.import_articles.each do |ia|
      t += ia.gjithsej_taksa
    end
    t
  end
  
  def shuma_qmimi
    self.import_articles.sum(:qmimi)
  end
  
  def shuma_transport
    t= 0
    self.import_articles.each do |a|
      t+= a.transport
    end
    t
  end
    
  def emri_klientit 
    self.client.kompania
  end

  def skaduar?
    if (self.data_skadimit - Date.today) <= 0
      true
    else 
      false
    end
  end

  def empty?
    self.import_gjendjas.all? { |i| i.empty? }
  end
  # validates :nr_dud, presence: true, length: {minimum:4, maximum:15}
  # validates :qmimi, presence:true, numericality: {only_float: true}
  # validates :sasia, presence:true, numericality: {only_float: true}
  # validates_date :data, presence: true
end
