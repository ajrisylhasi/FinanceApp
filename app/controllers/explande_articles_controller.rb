class ExplandeArticlesController < ApplicationController
  def destroy
    @el = ExplandeArticle.find(params[:id])
    @el.subexpls.each do |s|
      s.import_gjendja.sasia += s.sasia
      s.import_gjendja.pesha += s.pesha
      s.import_gjendja.qmimi +=  s.qmimi
      s.import_gjendja.save
      bashkimi_importit(s.import_gjendja.import)
    end
    @el.destroy
    redirect_to @el.exportlande
  end
end
