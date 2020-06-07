class PaletsController < ApplicationController
  before_action :set_palet, only: [:show, :edit, :update, :destroy]

  # GET /palets
  # GET /palets.json
  def index
    @palets = Palet.all
  end

  # GET /palets/1
  # GET /palets/1.json
  def show
    @palet.palet_products.build
    @palet.palet_packets.build
  end

  # GET /palets/new
  def new
    @palet = Palet.new
  end

  # GET /palets/1/edit
  def edit
  end

  # POST /palets
  # POST /palets.json
  def create
    @palet = Palet.new(palet_params)
    if @palet.save
      redirect_to @palet
    else
      render 'new'
    end
  end
  
  def files
    @palet = Palet.find(params[:id])
  end

  # PATCH/PUT /palets/1
  # PATCH/PUT /palets/1.json
  def update
    if @palet.update_attributes(palet_params)
      redirect_to @palet
    else
      render 'edit'
    end
  end

  # DELETE /palets/1
  # DELETE /palets/1.json
  def destroy
    @palet.destroy
    respond_to do |format|
      format.html { redirect_to palets_url, notice: 'Palet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_palet
      @palet = Palet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def palet_params
      params.require(:palet).permit(:nr_paletes, :dimensioni, files: [],
      palet_products_attributes: [:id, :product_id, :sasia, :_destroy],
      palet_packets_attributes: [:id, :packet_id, :sasia, :_destroy])
    end
end
