class StaticController < ApplicationController
  before_action :reset_notifications, only: [:home]
  before_action :home_lajm, only: [:home]
  
  def gjendja
    refresh_taksa
    if params[:search]
      params[:search] ||= {}
      @date_from = Date.parse(params[:search][:date_from]) rescue 7.days.ago.to_date.to_s
      @date_to = Date.parse(params[:search][:date_to]) rescue Date.today.to_s
      gjendja_bashkimi_search
    end
  end
  
  def mbetja
    
  end
  
  def home 
  end
  
  def reportet
  end
  
  def settings
    home_lajm
  end
  
  def article_present
    if params[:search]
      @articles = Article.where(["pershkrimi LIKE ?", "%#{params[:search]}%"]).or(Article.where(["cast(tarif_kodi as text) LIKE ?", "%#{params[:search]}%"]))
      @articles = @articles.select { |a| a.autorizims.first == Autorizim.first }
      @text = "No Articles with that Name or Taric Code in the Authorisation"
    else
      @articles = []
      @text = "Search for Article in the Authorisation"
    end
  end
end
