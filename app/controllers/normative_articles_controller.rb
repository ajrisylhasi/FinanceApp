class NormativeArticlesController < ApplicationController
  def destroy
    @ia = NormativeArticle.find(params[:id])
    @ia.destroy
    redirect_to @ia.normative
  end
end
