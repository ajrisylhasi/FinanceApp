class DoganasController < ApplicationController

  def index
    @doganas = Dogana.all
    @dogana ||= Dogana.new
    @errors = params[:errors]
  end
  
  def new
  end
  
  def create
      @dogana = Dogana.new(dogana_params)
      if @dogana.save
          redirect_to doganas_path
      else
        @errors = []
        if @dogana.errors.any?
          @dogana.errors.full_messages.each do |msg|
            @errors.push msg
          end
        end
        redirect_to doganas_path(errors: @errors)
      end
  end
  
  def edit
      @dogana = Dogana.find(params[:id])
  end
  
  def destroy
      @dogana = Dogana.find(params[:id])
      @dogana.destroy
      redirect_to doganas_path
  end
  
  def update 
      @dogana = Dogana.find(params[:id])
      if @dogana.update_attributes(dogana_params)
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
