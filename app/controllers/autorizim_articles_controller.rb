class AutorizimArticlesController < ApplicationController
  def destroy
    @aa = AutorizimArticle.find(params[:id])
    @aa.destroy
    redirect_to @aa.autorizim
  end
end

