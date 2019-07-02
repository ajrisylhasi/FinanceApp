class ExportProduct < ApplicationRecord
  belongs_to :export
  belongs_to :product
  belongs_to :normative
  validates :sasia, presence: true
  
  has_many :export_gjendjas, dependent: :destroy
  
  after_save :default_values
  
  def default_values
    qmimi = self.product.qmimi
    update_column(:qmimi, qmimi)
    vat = qmimi * self.export.client.vat / 100
    update_column(:vat, vat)
  end
end
