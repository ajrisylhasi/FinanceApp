class ImportsController < ApplicationController
  
  before_action :vlera_garancionit, only: [:new]

  def index
    @imports = Import.all
    @import ||= Import.new
    @errors = params[:errors]
  end
  
  def files
    @import = Import.find(params[:id])
  end

  def gjendja
    @import = Import.find(params[:id])
    @gjendja = {}
    bashkimi_importit(@import)
  end
  
  def create
    @import = Import.new(import_params)
    if @import.save
      redirect_to @import
    else  
      @errors = []
      if @import.errors.any?
        @import.errors.full_messages.each do |msg|
          @errors.push msg
        end
      end
      redirect_to imports_path(errors: @errors)
    end
  end
  
  def show
    @import = Import.find(params[:id])
    @taksa = @import.taksa
    @qm = @import.shuma_transport
    refresh_import(@import)
    refresh_gjendja
    bashkimi_importit(@import)
    refresh_taksa
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "imports/pdf", pdf: "Import PDF" }
    end
    @import.import_articles.build
  end
  
  def edit
    @import = Import.find(params[:id])
  end
  
  def destroy
    @import = Import.find(params[:id])
    
    @import.destroy
    redirect_to imports_path 
  end
  
  def update 
    @import = Import.find(params[:id])
    if params[:add_article_import]
      @import.update_attributes(import_params)
      vlera_autorizimit_garancion(@import)
      redirect_to @import
    elsif @import.update_attributes(import_params)
      refresh_import(@import)
      redirect_to @import
    else
      render 'show'
    end
  end
  
  def delete_image_attachment
    @file = ActiveStorage::Attachment.find(params[:id])
    @file.purge
    redirect_back(fallback_location: request.referer)
  end
  
  private
  
    def import_params
      params.require(:import).permit(:nr_dud, :nr_fatures, :data, :client_id, :transporti, :dogana, :destinimi, import_articles_attributes: [:id, :import_id, :article_id, :sasia, :qmimi, :emertimi, :pesha, :_destroy], files: [])
    end
    
    def find_import
      @import = Import.find(params[:id])
    end
end