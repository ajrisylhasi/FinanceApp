class MbylljasController < ApplicationController
  before_action :set_mbyllja, only: [:show, :edit, :update, :destroy]
  before_action :reset_notifications, only: [:new]
  # GET /mbylljas
  # GET /mbylljas.json
  def index
    @mbylljas = Mbyllja.all
    @mbyllja = Mbyllja.new
  end

  # GET /mbylljas/1
  # GET /mbylljas/1.json
  def show
  end

  # GET /mbylljas/new
  def new
  end

  # GET /mbylljas/1/edit
  def edit
  end

  # POST /mbylljas
  # POST /mbylljas.json
  def create
    @mbyllja = Mbyllja.new(mbyllja_params)

      if @mbyllja.save
        mbyllja(@mbyllja)
        redirect_to @mbyllja  
      end
  end

  # PATCH/PUT /mbylljas/1
  # PATCH/PUT /mbylljas/1.json
  def update
    respond_to do |format|
      if @mbyllja.update(mbyllja_params)
        format.html { redirect_to @mbyllja, notice: 'Mbyllja was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /mbylljas/1
  # DELETE /mbylljas/1.json
  def destroy
    
    rikthim_mbyllja(@mbyllja)
    @mbyllja.destroy
    redirect_to mbylljas_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mbyllja
      @mbyllja = Mbyllja.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mbyllja_params
      params.require(:mbyllja).permit(:nr_mbylljes, :data, import_ids: [])
    end
end
