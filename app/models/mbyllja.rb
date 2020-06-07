class Mbyllja < ApplicationRecord
  has_many :imports
  has_many :sub_mbylljas, dependent: :destroy
  validates :nr_mbylljes, presence: true
end
