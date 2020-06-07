class ExportlandesController < ApplicationController
  
  def index
    @exportlandes = Exportlande.all
    @exportlande ||= Exportlande.new
  end
  
  def show
    @exportlande = Exportlande.find(params[:id])
    @exportlande.explande_articles.build
  end
  
  def new
  end
  
  def edit
    @exportlande = Exportlande.find(params[:id])
  end

  def create
    @exportlande = Exportlande.new(exportlande_params)
    @fatura = Fatura.new(exportlande: @exportlande, data: @exportlande.data, nr_fatures: "Not Set")
    if @exportlande.save 
      redirect_to @exportlande
    else
      @errors = []
      if @exportlande.errors.any?
        @exportlande.errors.full_messages.each do |msg|
          @errors.push msg
        end
      end
      redirect_to exportlandes_path(errors: @errors)
    end
  end

  def update
    @exportlande = Exportlande.find(params[:id])
    if params[:add_explande_article]
      @exportlande.update_attributes(exportlande_params)
      veprimi_expl(@exportlande)
      redirect_to @exportlande
    elsif @exportlande.update_attributes(exportlande_params)
      redirect_to @exportlande
    else
      render 'show'
    end
  end

  def destroy
    @export = Exportlande.find(params[:id])
    @export.subexpls.each do |s|
      s.import_gjendja.sasia += s.sasia
      s.import_gjendja.pesha += s.pesha
      s.import_gjendja.qmimi += s.qmimi
      s.import_gjendja.save
      bashkimi_importit(s.import_gjendja.import)
    end
    @export.destroy
    redirect_to exportlandes_path
  end
  
  private
    
    def exportlande_params
      params.require(:exportlande).permit(:nr_exportit, :client_id, :data,
      explande_articles_attributes: [:id, :export_id, :import_id, :article_id, :import_article_id, :sasia, :_destroy])
    end
end
