class ExplandeArticle < ApplicationRecord
  belongs_to :exportlande
  belongs_to :import
  belongs_to :import_article
  belongs_to :article, optional: true
  validates :sasia, presence: true
  after_save :default_values
  has_many :subexpls, dependent: :destroy
  
  def default_values
    sas = self.sasia
    psh = self.import_article.pesha_njesi * sas
    qm = self.import_article.qmimi_njesi_norm * sas
    update_column(:article_id, self.import_article.article_id)
    update_column(:pesha, psh)
    update_column(:qmimi, qm)
    vat = self.qmimi * self.exportlande.client.vat / 100
    update_column(:vat, vat)
  end
end
