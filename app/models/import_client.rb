class ImportClient < ApplicationRecord
  belongs_to :import
  belongs_to :client
end
