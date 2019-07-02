class NjesisController < ApplicationController

  def index
    @njesis = Njesi.all
  end
  
  def new
    @njesi ||= Njesi.new
  end
  
  def create
      @njesi = Njesi.new(njesi_params)
      if @njesi.save
          flash[:success] = "Njesi successfuly updated"
          redirect_to @njesi
      else
          render 'new'
      end
  end
  
  def show
      @njesi = Njesi.find(params[:id])
      
  end
  
  def edit
      @njesi = Njesi.find(params[:id])
  end
  
  def destroy
      @njesi = Njesi.find(params[:id])
      @njesi.destroy
      flash[:success] = "Njesi deleted"
      redirect_to njesi_path
  end
  
  def update 
      @njesi = Njesi.find(params[:id])
      if @njesi.update_attributes(njesi_params)
        flash[:success] = "njesi successfuly updated"
        redirect_to @njesi
      else
        render 'edit'
      end
  end
  
  private
  
    def njesi_params
        params.require(:njesi).permit(:lloji)
    end
end
