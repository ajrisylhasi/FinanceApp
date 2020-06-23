class User < ApplicationRecord

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :name, presence: true
  has_secure_password
  validates :password, length: { minimum: 6 , allow_blank: true }
  validates :password_confirmation, length: { minimum: 6 , allow_blank: true }
  
  before_save :default_values
  
  def default_values
    self.data_auto ||= 14
    self.data_gar ||= 14
    self.data_imp ||= 14
    self.first_name ||= ""
    self.last_name ||= ""
    self.kategoria ||= "admin"
  end
end
