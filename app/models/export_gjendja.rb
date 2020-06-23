class ExportGjendja < ApplicationRecord
  belongs_to :export
  belongs_to :export_product
  has_many :subs, dependent: :destroy
end
