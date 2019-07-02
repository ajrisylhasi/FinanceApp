class DestinimsController < ApplicationController

  def index
    @destinims = Destinim.all
  end
  
  def new
    @destinim ||= Destinim.new
  end
  
  def create
      @destinim = Destinim.new(destinims_params)
      if @destinim.save
          flash[:success] = "Destinims successfuly updated"
          redirect_to destinims_path
      else
          render 'new'
      end
  end
  
  def edit
      @destinim = Destinim.find(params[:id])
  end
  
  def destroy
      @destinim = Destinim.find(params[:id])
      @destinim.destroy
      flash[:success] = "Destinims deleted"
      redirect_to destinims_path
  end
  
  def update 
      @destinim = Destinim.find(params[:id])
      if @destinim.update_attributes(destinims_params)
        flash[:success] = "Destinims successfuly updated"
        redirect_to destinims_path
      else
        render 'edit'
      end
  end
  
  private
  
    def destinims_params
        params.require(:destinim).permit(:kodi, :pershkrimi)
    end
end
