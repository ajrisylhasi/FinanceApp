class AutorizimArticle < ApplicationRecord
  belongs_to :article
  belongs_to :autorizim
  
  before_save :default_values
  
  def default_values
    self.max ||= 0
  end
  
end
