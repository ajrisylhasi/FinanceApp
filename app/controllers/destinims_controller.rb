class DestinimsController < ApplicationController

  def index
    @destinims = Destinim.all
    @destinim ||= Destinim.new
    @errors = params[:errors]
  end
  
  def new
  end
  
  def create
      @destinim = Destinim.new(destinims_params)
      if @destinim.save
          redirect_to destinims_path
      else
        @errors = []
        if @destinim.errors.any?
          @destinim.errors.full_messages.each do |msg|
            @errors.push msg
          end
        end
        redirect_to destinims_path(errors: @errors)
      end
  end
  
  def edit
      @destinim = Destinim.find(params[:id])
  end
  
  def destroy
      @destinim = Destinim.find(params[:id])
      @destinim.destroy
      redirect_to destinims_path
  end
  
  def update 
      @destinim = Destinim.find(params[:id])
      if @destinim.update_attributes(destinims_params)
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
