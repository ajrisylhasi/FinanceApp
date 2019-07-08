class GarancionsController < ApplicationController
  
  before_action :refresh_taksa, only: [:index]
  
  def index

    @garancions = Garancion.all
    @garancion ||= Garancion.new
  end
  
  def new
  end
  
  def create
      @garancion = Garancion.new(garancion_params)
      if @garancion.save
          flash[:success] = "garancion successfuly updated"
          redirect_to @garancion
      else
          render 'new'
      end
  end
  
  def show
      @garancion = Garancion.find(params[:id])
  end
  
  def edit
      @garancion = Garancion.find(params[:id])
  end
  
  def destroy
    @garancion = Garancion.find(params[:id])
    @garancion.destroy
    flash[:success] = "Garancion deleted"
    redirect_to garancions_path
  end
  
  def update 
      @garancion = Garancion.find(params[:id])
      if @garancion.update_attributes(garancion_params)
        flash[:success] = "garancion successfuly updated"
        redirect_to @garancion
      else
        render 'edit'
      end
  end
  
  private
  
    def garancion_params
        params.require(:garancion).permit(:data, :data_skadimit, :vlera, :pershkrimi, :identifikimi)
    end
end
