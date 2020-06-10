class Garancion < ApplicationRecord
  has_many :garancion_gjendjas, dependent:  :destroy
  has_many :import_gjendjas, through: :garancion_gjendjas
  
  after_save :default_values

  validates :data_skadimit, presence: true
  validates :data, presence: true
  validates :identifikimi, presence: true, uniqueness: true
  
  def default_values
    update_column(:vlera_t, self.vlera)
  end

  def graph_pershkrimi
  end
end
