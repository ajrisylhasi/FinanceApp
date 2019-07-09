class GarancionsController < ApplicationController
  
  before_action :refresh_taksa, only: [:index]
  
  def index
    @garancions = Garancion.all
    @garancion ||= Garancion.new
    @errors = params[:errors]
  end
  
  def new
  end
  
  def create
      @garancion = Garancion.new(garancion_params)
      if @garancion.save
          flash[:success] = "garancion successfuly updated"
          redirect_to @garancion
      else
        @errors = []
        if @garancion.errors.any?
          @garancion.errors.full_messages.each do |msg|
            @errors.push msg
          end
        end
        redirect_to exports_path(errors: @errors)
      end
      refresh_taksa
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
    redirect_to garancions_path
  end
  
  def update 
      @garancion = Garancion.find(params[:id])
      if @garancion.update_attributes(garancion_params)
        redirect_to @garancion
      else
        render 'edit'
      end
      refresh_taksa
  end
  
  private
  
    def garancion_params
        params.require(:garancion).permit(:data, :data_skadimit, :vlera, :pershkrimi, :identifikimi)
    end
end
