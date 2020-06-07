class Autorizim < ApplicationRecord
  has_many :autorizim_articles, dependent: :destroy
  has_many :articles, through: :autorizim_articles
  accepts_nested_attributes_for :autorizim_articles, allow_destroy: true
  has_many_attached :files
  
  has_many :autorizim_products, dependent: :destroy
  has_many :products, through: :autorizim_products
  accepts_nested_attributes_for :autorizim_products, allow_destroy: true
end
