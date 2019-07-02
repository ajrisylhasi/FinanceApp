class ExplandeArticle < ApplicationRecord
  belongs_to :exportlande
  belongs_to :import
  belongs_to :import_article
  validates :sasia, presence: true
  after_save :default_values
  has_many :subexpls, dependent: :destroy
  
  def default_values
    sas = self.sasia
    psh = self.import_article.pesha_njesi * sas
    qm = self.import_article.qmimi_njesi_norm * sas
    update_column(:pesha, psh)
    update_column(:qmimi, qm)
  end
end
