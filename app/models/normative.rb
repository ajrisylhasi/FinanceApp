class Normative < ApplicationRecord
    has_many :normative_articles, dependent: :destroy
    has_many :articles, through: :normative_articles
    accepts_nested_attributes_for :normative_articles, allow_destroy: true
    has_many_attached :files    
    
    has_one :export_product
    belongs_to :product
    
    
    before_save :default_values
    
    def default_values
        self.kategoria ||= "manual"
    end

    def mbetja_ne_sasi
        vlera = 0
        self.normative_articles.each do |a|
            vlera += a.mbetja_ne_sasi
        end
        vlera
    end
    
    def mbetja_ne_peshe
        vlera = 0
        self.normative_articles.each do |a|
            vlera += a.mbetja_ne_peshe
        end
        vlera
    end
    
    def sasia_neto
        vlera = 0
        self.normative_articles.each do |a|
            vlera += a.sasia_neto
        end
        vlera
    end
    
    def pesha_neto
        vlera = 0
        self.normative_articles.each do |a|
            vlera += a.pesha_neto
        end
        vlera
    end

    def pesha_b
        vlera = 0 
        self.normative_articles.each do |a|
            vlera += a.pesha_neto
        end
        vlera
    end
    
    def pesha_n
        vlera = 0
        self.normative_articles.each do |na|
          if na.article.kategoria == "lende"
            vlera += na.pesha_neto
          end
        end
        vlera
    end
    
    def show_text
        "#{nr_normatives} - #{self.product.pershkrimi}"
    end
    # validates :nr_dud, presence: true, length: {minimum:4, maximum:15}
    # validates :qmimi, presence:true, numericality: {only_float: true}
    # validates :sasia, presence:true, numericality: {only_float: true}
    # validates_date :data, presence: true
    # reject_if: proc { |attributes| attributes['pershkrimi'].blank? || attributes['qmimi_kg'].blank? || attributes['sasia_kg'].blank? ||attributes['tarif_kodi'].blank?}
end 
