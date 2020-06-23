class Destinim < ApplicationRecord
  def komplet 
    "#{kodi}=*=#{pershkrimi}"
  end
  
  def komplet_pamja
    "(#{kodi}) #{pershkrimi}"
  end
end
