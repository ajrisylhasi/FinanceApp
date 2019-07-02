class Fee < ApplicationRecord
  belongs_to :fatura
  
  before_save :pre
  
  def pre
    self.qmimi ||= 0
    self.pesha ||= 0
    self.pesha_neto ||= 0
    self.sasia ||= 0
  end
end
