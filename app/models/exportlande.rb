class Exportlande < ApplicationRecord
  has_many :explande_articles, dependent: :destroy
  has_many :import_articles, through: :explande_articles
  belongs_to :client
  has_many :subexpls, dependent: :destroy
  has_one :fatura, dependent: :destroy
  accepts_nested_attributes_for :explande_articles, allow_destroy: true

 def pesha
    vlera = 0
    self.explande_articles.each do |a|
      vlera += a.subexpls.first.pesha
    end
    vlera
  end

end
