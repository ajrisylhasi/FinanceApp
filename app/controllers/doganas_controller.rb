class DoganasController < ApplicationController

  def index
    @doganas = Dogana.all
  end
  
  def new
    @dogana ||= Dogana.new
  end
  
  def create
      @dogana = Dogana.new(dogana_params)
      if @dogana.save
          flash[:success] = "Dogana successfuly updated"
          redirect_to doganas_path
      else
          render 'new'
      end
  end
  
  def edit
      @dogana = Dogana.find(params[:id])
  end
  
  def destroy
      @dogana = Dogana.find(params[:id])
      @dogana.destroy
      flash[:success] = "Dogana deleted"
      redirect_to doganas_path
  end
  
  def update 
      @dogana = Dogana.find(params[:id])
      if @dogana.update_attributes(dogana_params)
        flash[:success] = "Dogana successfuly updated"
        redirect_to doganas_path
      else
        render 'edit'
      end
  end
  
  private
  
    def dogana_params
        params.require(:dogana).permit(:kodi, :pershkrimi)
    end
end
