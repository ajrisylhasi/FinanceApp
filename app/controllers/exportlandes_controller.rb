class ExportlandesController < ApplicationController
  
  def index
    @exportlandes = Exportlande.all
    @exportlande ||= Exportlande.new
  end
  
  def show
    @exportlande = Exportlande.find(params[:id])
    @pesha = @exportlande.pesha
    @exportlande.explande_articles.build
  end
  
  def new
  end
  
  def edit
    @exportlande = Exportlande.find(params[:id])
  end

  def gjendja
    @exportlande = Exportlande.find(params[:id])
    bashko(@exportlande)
    @numri = @subsat.count
    @tot_array = []
    @tot_pesha = 0
    @tot_qmimi = 0
    @tot_dog = 0
    @tot_akciza = 0
    @tot_tvsh = 0
    @tot_taksa = 0
    @subsat.each do |sub_g|
      sub_g.each do |x, y|
        @tot_pesha += y[1]
        @tot_qmimi += y[2]
        @tot_dog += y[3]
        @tot_akciza += y[4]
        @tot_tvsh += y[5]
        @tot_taksa += y[6]
      end
    end
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "exportlandes/pdf", pdf: "Specifikacioni per Shkarkim Te Lendes Se Pare- #{Date.today.to_s}", orientation: 'Landscape' }
      format.csv {
        all_keys_as_array = ["Importi", "Emertimi", "Tarif Kodi", "Kodi i Artikullit", "Pershkrimi", "Sasia", "Njesia", "Pesha",
                         "Qmimi Total", "Taksa Doganore", "Akciza", "TVSH", "Gjithsej Taksa"]
        csv_string = CSV.generate do |csv|
          csv << ["Adresa: #{kompania.adresa}", "", "", "", "", "", "", "", "", "", "", "", "Nr. VAT: #{kompania.numri_tvsh}"]
          csv << ["#{kompania.zip} #{kompania.qyteti}, #{kompania.shteti}", "", "", "", "", "", "#{kompania.kompania}", "", "", "", "", "", "Nr. Fiskal: #{kompania.numri_fiskal}"]
          csv << ["Numri Kontaktues: #{current_user.tel_number}", "", "", "", "", "", "", "", "", "", "", "", "Nr. Biznesit: #{kompania.numri_biznesit}"]
          csv << ["Email: #{current_user.email}", "", "", "", "", "", "Eksporti: #{@exportlande.nr_exportit}", "", "", "", "", "", "Nr. Identifikues: #{kompania.numri_identifikues}"]
          csv << [""]
          csv << all_keys_as_array
          @subsat.each do |sub_group|
            sub_group.sort_by { |x, y| x[1].to_i }.each do |x, y|
              csv << [ x[2].nr_dud, x[1], Article.where(kodi: x[0]).first.tarif_kodi, x[0], Article.where(kodi: x[0]).first.pershkrimi, y[0].round(3), Article.where(kodi: x[0]).first.njesia, y[1].round(3), y[2].round(3), y[3].round(3), y[4].round(3), y[5].round(3), y[6].round(3)]
            end
          end
        end
        send_data csv_string, filename: "Specifikacioni Lande e Pare-#{@exportlande.nr_exportit}.csv"
      }
    end
  end

  def create
    @exportlande = Exportlande.new(exportlande_params)
    @fatura = Fatura.new(exportlande: @exportlande, data: @exportlande.data, nr_fatures: "Not Set")
    if @exportlande.save 
      redirect_to @exportlande
    else
      @errors = []  
      if @exportlande.errors.any?
        @exportlande.errors.full_messages.each do |msg|
          @errors.push msg
        end
      end
      redirect_to exportlandes_path(errors: @errors)
    end
  end

  def update
    @exportlande = Exportlande.find(params[:id])
    if params[:add_explande_article]
      @exportlande.update_attributes(exportlande_params)
      veprimi_expl(@exportlande)
      redirect_to @exportlande
    elsif @exportlande.update_attributes(exportlande_params)
      redirect_to @exportlande
    else
      @errors = []
      if @exportlande.errors.any?
        @exportlande.errors.full_messages.each do |msg|
          @errors.push msg
        end
      end
      redirect_to exportlande_path @exportlande, errors: @errors
    end
  end

  def destroy
    @export = Exportlande.find(params[:id])
    @export.subexpls.each do |s|
      s.import_gjendja.sasia += s.sasia
      s.import_gjendja.pesha += s.pesha
      s.import_gjendja.qmimi += s.qmimi
      s.import_gjendja.save
      bashkimi_importit(s.import_gjendja.import)
    end
    @export.destroy
    redirect_to exportlandes_path
  end
  
  private
    
    def exportlande_params
      params.require(:exportlande).permit(:nr_exportit, :client_id, :data,
      explande_articles_attributes: [:id, :export_id, :import_id, :article_id, :import_article_id, :sasia, :_destroy])
    end
end
