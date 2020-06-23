class Kompani < ApplicationRecord
  validates :kompania, presence: true
  mount_uploader :image, ImageUploader
end
