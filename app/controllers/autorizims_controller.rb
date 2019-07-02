class AutorizimsController < ApplicationController
  before_action :find_autorizim, only: [:show, :edit, :update, :destroy]

  
  def files
    @autorizim = Autorizim.find(params[:id])
  end
    
  def show
      @autorizim = Autorizim.find(params[:id])
      @autorizim.autorizim_articles.build
      @autorizim.autorizim_products.build
  end
  
  def edit
      @autorizim = Autorizim.find(params[:id])
  end
  
  def destroy
      @autorizim.destroy
      flash[:success] = "Autorizim deleted"
      redirect_to autorizims_path
  end
  
  def update 
      @autorizim = Autorizim.find(params[:id])
      if @autorizim.update_attributes(autorizim_params)
        redirect_to @autorizim
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
  
    def autorizim_params
        params.require(:autorizim).permit(:data_leshimit, :data_skadimit, :qyteti, :shteti, :adresa, files: [],
        autorizim_articles_attributes: [:id, :autorizim_id, :article_id, :max, :_destroy],
        autorizim_products_attributes: [:id, :autorizim_id, :product_id, :_destroy])
    end
    
    def find_autorizim
        @autorizim = Autorizim.find(params[:id])
    end
end
