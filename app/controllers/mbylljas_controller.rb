class MbylljasController < ApplicationController
  before_action :set_mbyllja, only: [:show, :edit, :update, :destroy]
  # GET /mbylljas
  # GET /mbylljas.json
  def index
    @mbylljas = Mbyllja.all
    @mbyllja = Mbyllja.new
    @errors = params[:errors]
  end

  # GET /mbylljas/1
  # GET /mbylljas/1.json
  def show
    @totali_pesha = 0
    @totali_qmimi_tot = 0
    @totali_taksa_dogana = 0
    @totali_taksa_akciza = 0
    @totali_taksa_tvsh = 0
    @totali_gjithsej_taksat = 0
    @mbyllja.sub_mbylljas.each do |y|
      @totali_pesha += y.pesha
      @totali_qmimi_tot += y.qmimi_tot
      @totali_taksa_dogana += y.taksa_dogana
      @totali_taksa_akciza += y.taksa_akciza
      @totali_taksa_tvsh += y.taksa_tvsh
      @totali_gjithsej_taksat += y.gjithsej_taksa
    end
  end

  # GET /mbylljas/new
  def new
    @mbyllja = Mbyllja.new
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
      else
        @errors = []
        if @mbyllja.errors.any?
          @mbyllja.errors.full_messages.each do |msg|
            @errors.push msg
          end
        end
        redirect_to mbylljas_path(errors: @errors)
      end
  end

  # PATCH/PUT /mbylljas/1
  # PATCH/PUT /mbylljas/1.json
  def update
    respond_to do |format|
      if @mbyllja.update(mbyllja_params)
        redirect_to @mbyllja
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
