class KompanisController < ApplicationController
  def edit
    @kompania = Kompani.find(params[:id])
    
  end
  
  def update
    @kompania = Kompani.find(params[:id])
    if @kompania.update_attributes(kompani_params)
      redirect_to home_path
    else
      redirect_to edit_kompani_path(@kompania)
    end
  end
  
    
    def kompani_params
      params.require(:kompani).permit(:kompania, :numri_fiskal, :numri_biznesit, :numri_tvsh, :shteti, :qyteti, :adresa, :zip, :numri_identifikues, :image)
    end
end
