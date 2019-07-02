class Mbyllja < ApplicationRecord
  has_many :imports
  has_many :sub_mbylljas, dependent: :destroy
end
