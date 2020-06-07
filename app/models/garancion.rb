class Garancion < ApplicationRecord
  has_many :garancion_gjendjas, dependent:  :destroy
  has_many :import_gjendjas, through: :garancion_gjendjas
  
  after_save :default_values
  
  def default_values
    update_column(:vlera_t, self.vlera)
  end

  def graph_pershkrimi
  end
end
