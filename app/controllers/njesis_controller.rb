class NjesisController < ApplicationController

  def index
    @njesis = Njesi.all
    @njesi ||= Njesi.new
    @errors = params[:errors]
  end
  
  def new
  end
  
  def create
      @njesi = Njesi.new(njesi_params)
      if @njesi.save
          redirect_to home_path
      else
        @errors = []
        if @njesi.errors.any?
          @njesi.errors.full_messages.each do |msg|
            @errors.push msg
          end
        end
        redirect_to njesis_path(errors: @errors)
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
      redirect_to njesis_path
  end
  
  def update 
      @njesi = Njesi.find(params[:id])
      if @njesi.update_attributes(njesi_params)
        redirect_to njesis_path
      else
        render 'edit'
      end
  end
  
  private
  
    def njesi_params
        params.require(:njesi).permit(:lloji)
    end
end
