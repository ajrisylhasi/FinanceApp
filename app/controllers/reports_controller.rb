class ReportsController < ApplicationController
  
  skip_before_action :access
  

  def products
    @list = ExportProduct.all
    @clients = Client.all
    @products = Product.all
    params[:search] ||= {}
    if Import.count != 0 
      @date_from = Date.parse(params[:search][:date_from]) rescue Import.all.sort_by(&:data).first.data.to_s
    else
      @date_from = Date.parse(params[:search][:date_from]) rescue 7.days.ago.to_date.to_s
    end
    if Export.count != 0
      @date_to = Date.parse(params[:search][:date_to]) rescue Export.all.sort_by(&:data).last.data.to_s
    else
      @date_to = Date.parse(params[:search][:date_to]) rescue Date.today.to_s
    end
    @client = Client.find(params[:search][:client_id]) rescue 0
    @product = Product.find(params[:search][:product_id]) rescue 0
    product_search
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "reports/product_search", pdf: "Product Report - #{Date.today.to_s}"}
    end
  end
  
  def gjendja
    @totali_pesha = 0
    @totali_qmimi_tot = 0
    @totali_taksa_dogana = 0
    @totali_taksa_akciza = 0
    @totali_taksa_tvsh = 0
    @totali_gjithsej_taksat = 0
    @import = 0
    @imports = []
    if params[:search]
      params[:search] ||= {}
      @date = Date.parse(params[:search][:date]) rescue 0
      @import = Import.find(params[:search][:import_id]) rescue 0
      gjendja_bashkimi_search
    else
      gjendja_bashkimi
    end
    all_keys_as_array = ["Data", "Importi", "Emertimi", "Tarif Kodi", "Kodi Artikullit", "Pershkrimi", "Sasia", "Njesia", "Pesha",
                         "Qmimi Total", "Taksa Doganore", "Akciza", "TVSH", "Gjithsej Taksa"]
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "reports/gjendja", pdf: "State Report - #{Date.today.to_s}"}
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << all_keys_as_array
          @gjendja.each do |y, x|
            csv << [ y[2].data, y[2].nr_dud, y[1], x[3].article.tarif_kodi, y[0], Article.where(kodi: y[0]).first.pershkrimi,
                     x[0].round(4), x[3].njesia, x[1].round(4), x[2].round(4), x[4].round(4), x[5].round(4), x[6].round(4), x[7].round(4)]
          end
        end
        if @date != 0
          send_data csv_string, filename: "Gjendja-#{@date}.csv"
        else
          send_data csv_string, filename: "Gjendja-#{Date.today}.csv"
        end
      }
    end
  end
  
  def imports
    @list = ImportArticle.all
    @clients = Client.all
    @articles = Article.all
    params[:search] ||= {}
    if Import.count != 0 
      @date_from = Date.parse(params[:search][:date_from]) rescue Import.all.sort_by(&:data).first.data.to_s
    else
      @date_from = Date.parse(params[:search][:date_from]) rescue 7.days.ago.to_date.to_s
    end
    if Export.count != 0
      @date_to = Date.parse(params[:search][:date_to]) rescue Export.all.sort_by(&:data).last.data.to_s
    else
      @date_to = Date.parse(params[:search][:date_to]) rescue Date.today.to_s
    end
    @client = Client.find(params[:search][:client_id]) rescue 0
    @article = Article.find(params[:search][:article_id]) rescue 0
    import_search
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "reports/import_search", pdf: "Import Report - #{Date.today.to_s}"}
      
    end
  end

  def mbetja
    if params[:search]
      params[:search] ||= {}
      @date = Date.parse(params[:search][:date]) rescue 0
      mbetja_bashkimi_search
    else
      mbetja_bashkimi
    end
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "reports/mbetja", pdf: "Residue Report - #{Date.today.to_s}"}
    end
  end
  
  def official
    @totali_pesha = 0
    @totali_qmimi_tot = 0
    @totali_taksa_dogana = 0
    @totali_taksa_akciza = 0
    @totali_taksa_tvsh = 0
    @totali_gjithsej_taksat = 0
    @import = 0
    @imports = []
    if params[:search]
      params[:search] ||= {}
      @date = Date.parse(params[:search][:date]) rescue 0
      @import = Import.find(params[:search][:import_id]) rescue 0
      official_bashkimi_search
    else
      official_bashkimi
    end
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "reports/official", pdf: "Official Report - #{Date.today.to_s}"}
    end
  end
end
