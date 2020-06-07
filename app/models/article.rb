class Article < ApplicationRecord
    has_many :normatives, through: :normative_articles
    has_many :normative_articles, dependent: :destroy
    has_many :import_articles, dependent: :destroy
    has_many :imports, through: :import_articles
    validates  :njesia, presence: true
    
    has_many :explande_articles
    
    has_many :autorizim_articles, dependent: :destroy
    has_many :autorizims, through: :autorizim_articles
    
    accepts_nested_attributes_for :autorizim_articles, allow_destroy: true
    
    def pershkrimi_njesia
        "(#{self.kodi}) #{pershkrimi} - #{njesia}"
    end
    
    def name
        "#{pershkrimi} - (#{kodi})"
    end
    # validates :nr_dud, presence: true, length: {minimum:4, maximum:15}
    # validates :qmimi, presence:true, numericality: {only_float: true}
    # validates :sasia, presence:true, numericality: {only_float: true}
    # validates_date :data, presence: true
end
