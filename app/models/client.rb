class Client < ApplicationRecord
  has_many :imports
  has_many :exports
  has_many :exportlandes
  
  validates :vat, presence: true
end
