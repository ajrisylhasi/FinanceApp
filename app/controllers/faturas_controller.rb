class FaturasController < ApplicationController
  
  def index
    @faturas = Fatura.all.select { |f| 
      if f.export == nil 
        f.exportlande.explande_articles.count != 0
      else
        f.export.export_products.count != 0 
      end
    }
    respond_to do |format|
      format.html
      format.csv { send_data @faturas.to_csv}
    end
  end
  
  def edit
    @fatura = Fatura.find(params[:id])
  end
  
  def update
    @fatura = Fatura.find(params[:id])
    if @fatura.update_attributes(faturas_params)
      @fatura.save
      redirect_to @fatura
    else
      redirect_to edit_fatura_path(@fatura)
    end
  end
  
  def change_edit 
    @fatura = Fatura.find(params[:id])
    @fatura.edit = 1
    @fatura.save
    redirect_to @fatura
  end
  
  def show
    @fatura = Fatura.find(params[:id])
    @total_pa_vat = 0
    @total_vat = 0
    @total = 0
    @pesha_n = 0
    @pesha_b = 0
    
    unless @fatura.export.nil?
      @export = @fatura.export
      product_search_export(@export)
      @list.each do |ep|
        @total_pa_vat +=  ep.qmimi * ep.sasia 
        @total_vat += ep.vat * ep.sasia
        @pesha_n += ep.normative.pesha_n * ep.sasia
        @pesha_b += ep.normative.pesha_b * ep.sasia
      end
    else
      @exportlande = @fatura.exportlande
      product_search_exportlande(@exportlande)
      @list.each do |ep|
        @total_pa_vat +=  ep.qmimi * ep.sasia 
        @total_vat += ep.vat * ep.sasia
        @pesha_n += ep.pesha * ep.sasia
      end
    end

    @fatura.fees.each do |f|
      qmimi_fee = f.qmimi * f.sasia
      @total_pa_vat +=  qmimi_fee
      @total_vat += @export.client.vat * qmimi_fee / 100
      @pesha_b += f.pesha 
      @pesha_n += f.pesha_neto 
    end
    @total = @total_pa_vat + @total_vat
    @fatura.fees.build
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "faturas/fatura.pdf", pdf: "Fatura - #{@fatura.data}", orientation: 'Portrait' }
      
    end
    
  end
  
  private
    def faturas_params
      params.require(:fatura).permit(:id, :nr_fatures, :data, :note, :default, fees_attributes: [:id, :pershkrimi, :sasia, :pesha, :pesha_neto, :qmimi, :_destroy])
    end
    
end
