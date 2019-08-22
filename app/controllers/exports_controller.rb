class ExportsController < ApplicationController
  before_action :refresh_gjendja, only: [:update]
  after_action :refresh_gabimet, only: [:show]
  
  def index
    @exports = Export.all
    @export ||= Export.new
    @errors = params[:errors]
  end
  
  def show
    @export = Export.find(params[:id])
    @pesha_b = @export.pesha_b
    @pesha_n = @export.pesha_n
    @pesha_bruto = @export.pesha_bruto
    @ep = @export.export_products.build
  end
  
  def fatura
    @export = Export.find(params[:id])
    @fatura = @export.fatura
  end
  
  def gjendja
    @export = Export.find(params[:id])
    bashkimi_sub(@export)
    @numri = @subsat.count
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "exports/pdf", pdf: "Specifikacioni per Shkarkim - #{Date.today.to_s}", orientation: 'Landscape' }
      format.csv {
        all_keys_as_array = ["Importi", "Emertimi", "Tarif Kodi", "Kodi i Artikullit", "Pershkrimi", "Sasia", "Njesia", "Pesha",
                         "Qmimi Total", "Taksa Doganore", "Akciza", "TVSH", "Gjithsej Taksa"]
        csv_string = CSV.generate do |csv|
          csv << ["Adresa: #{kompania.adresa}", "", "", "", "", "", "", "", "", "", "", "", "Nr. VAT: #{kompania.numri_tvsh}"]
          csv << ["#{kompania.zip} #{kompania.qyteti}, #{kompania.shteti}", "", "", "", "", "", "#{kompania.kompania}", "", "", "", "", "", "Nr. Fiskal: #{kompania.numri_fiskal}"]
          csv << ["Numri Kontaktues: #{current_user.tel_number}", "", "", "", "", "", "", "", "", "", "", "", "Nr. Biznesit: #{kompania.numri_biznesit}"]
          csv << ["Email: #{current_user.email}", "", "", "", "", "", "Eksporti: #{@export.nr_exportit}", "", "", "", "", "", "Nr. Identifikues: #{kompania.numri_identifikues}"]
          csv << [""]
          csv << all_keys_as_array
          @subsat.each do |sub_group|
            sub_group.sort_by { |x, y| x[1].to_i }.each do |x, y|
              csv << [ x[2].nr_dud, x[1], Article.where(kodi: x[0]).first.tarif_kodi, x[0], Article.where(kodi: x[0]).first.pershkrimi, y[0].round(3), Article.where(kodi: x[0]).first.njesia, y[1].round(3), y[2].round(3), y[3].round(3), y[4].round(3), y[5].round(3), y[6].round(3)]
            end
          end
        end
        send_data csv_string, filename: "Specifikacioni-#{@export.nr_exportit}.csv"
      }
    end
    
  end
  
  def specifikacions
    @exports = Export.all
  end
  
  def mbetja
    @export = Export.find(params[:id])
    refresh_mbetja_export(@export)
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "exports/pdf_mbetja", pdf: "Mbetjet nga Shkarkimi - #{@export.data}", orientation: 'Landscape' }
    end
  end
  
  def new
  end
  
  def edit
    @export = Export.find(params[:id])
  end

  def create
    @export = Export.new(export_params)
    @fatura = Fatura.new(export: @export, data: @export.data, nr_fatures: "Not Set")
    if @export.save 
      redirect_to @export
    else
      @errors = []
      if @export.errors.any?
        @export.errors.full_messages.each do |msg|
          @errors.push msg
        end
      end
      redirect_to exports_path(errors: @errors)
    end
  end

  def update
    @export = Export.find(params[:id])
    if params[:add_product_export]
      @export.update_attributes(export_params)
      refresh_export(@export)
      bashkimi_exportit(@export)
      veprimi(@export)
      redirect_to @export
    elsif @export.update_attributes(export_params)
      redirect_to @export
    else
      render 'show'
    end
  end

  def destroy
    @export = Export.find(params[:id])
    @export.subs.each do |s|
      s.import_gjendja.sasia += ( s.sasia + s.mbetja )
      s.import_gjendja.pesha += ( s.pesha + s.mbetja_peshe)
      s.import_gjendja.qmimi += ( s.qmimi + s.mbetja_qmimi)
      s.import_gjendja.save
      bashkimi_importit(s.import_gjendja.import)
    end
    @export.destroy
    redirect_to exports_path
  end
  
  def files
    @export = Export.find(params[:id])
  end
  
  def delete_image_attachment
    @file = ActiveStorage::Attachment.find(params[:id])
    @file.purge
    redirect_back(fallback_location: request.referer)
  end
    
  private
    def find_export
      @export = Export.find(params[:id])
    end
    
    def export_params
      params.require(:export).permit(:nr_exportit, :client_id, :data, :nr_fatures, 
      export_products_attributes: [:id, :export_id, :product_id, :normative_id, :sasia, :_destroy],
      packing_list_attributes: [:id, :export_id, :_destroy],
      lists_attributes: [:id, :packing_list_id, :_destroy],
      faturas_attributes: [:id, :nr_fatures, :data],
      files: [])
    end
end
