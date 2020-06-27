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
    all_keys_as_array = ["Klienti", "Data e Eksportit", "Numri i Eksportit", "Numri i Fatures", "Data e Fatures", "Produkti", "Sasia", "Qmimi", "Total"]
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "reports/product_search", pdf: "Exports Report-#{@date_from}/#{@date_to}", :encoding => 'UTF-8;'}
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << all_keys_as_array
          @list.each do |y|
            csv << [ y.export.client.kompania, y.export.data, y.export.nr_exportit, y.export.fatura.nr_faturess, y.export.fatura.data, y.product.pershkrimi,
                     y.sasia, y.qmimi, y.qmimi * y.sasia ]
          end
        end
        send_data csv_string, filename: "Product Export-#{@date_from}/#{@date_to}.csv"
      }
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
    all_keys_as_array = ["Data", "Importi", "Emertimi", "Tarif Kodi", "Kodi Artikullit", "Pershkrimi", "Sasia", "Njesia", "Pesha (KG)",
                         "Qmimi Total (€)", "Taksa Doganore (€)", "Akciza (€)", "TVSH (€)", "Gjithsej Taksa (€)"]
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "reports/gjendja", pdf: "State Report - #{Date.today.to_s}", :encoding => 'UTF-8;'}
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << all_keys_as_array
          @gjendja.each do |y, x|
            csv << [ y[2].data, y[2].nr_dud, y[1], x[3].article.tarif_kodi, y[0], Article.where(kodi: y[0]).first.pershkrimi,
                     x[0].round(4), x[3].njesia, x[1].round(4), x[2].round(4), x[4].round(4), x[5].round(4), x[6].round(4), x[7].round(4)]
          end
          csv << ["", "", "", "", "", "Totali", "", "", @totali_pesha.round(4), @totali_qmimi_tot.round(4), @totali_taksa_dogana.round(4), @totali_taksa_akciza.round(4), @totali_taksa_tvsh.round(4), @totali_gjithsej_taksat.round(4)]
        end
        if @date != 0
          send_data csv_string, filename: "Gjendja e Pergjithshme-#{@date}.csv"
        else
          send_data csv_string, filename: "Gjendja e Pergjithshme-#{Date.today}.csv"
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

      @val = params[:search][:validity].to_i rescue 0
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
    all_keys_as_array = ["Klienti", "Data Importit", "Nr. Importit", "Nr. Fatures", "Emertimi", "Artikulli", "Sasia", "Pesha (KG)",
                         "Qmimi Total (€)"]
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "reports/import_search", pdf: "Import Report - #{Date.today.to_s}", :encoding => 'UTF-8;'}
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << all_keys_as_array
          @list.each do |ep|
            csv << [ ep.import.client.kompania, ep.import.data, ep.import.nr_dud, ep.import.nr_fatures , ep.emertimi, ep.article.pershkrimi,
                     ep.sasia.round(2), ep.pesha.round(2), ep.qmimi.round(2)]
          end
        end
        send_data csv_string, filename: "Importet-#{Date.today}.csv"
      }
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
    all_keys_as_array = ["Exporti", "Importi", "Emertimi", "Tarif Kodi", "Kodi Artikullit", "Pershkrimi", "Sasia", "Njesia", "Pesha (KG)",
                         "Qmimi Total (€)", "Taksa Doganore (€)", "Akciza (€)", "TVSH (€)", "Gjithsej Taksa (€)"]
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "reports/mbetja", pdf: "Residue Report - #{Date.today.to_s}", :encoding => 'UTF-8;'}
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << all_keys_as_array
          @hash_mbetja.sort_by {|x, y| x[1]}.each do |x, y|
            csv << [ x[3].nr_exportit, x[2].nr_dud, x[1], Article.where(kodi: x[0]).first.tarif_kodi, x[0], Article.where(kodi: x[0]).first.pershkrimi,
                     '%.2f' % y[0].round(2), Article.where(kodi: x[0]).first.njesia, '%.2f' % y[1].round(2), '%.2f' % y[3].round(2), '%.2f' % y[4].round(2), '%.2f' % y[5].round(2), '%.2f' % y[6].round(2), '%.2f' % y[7].round(2)]
          end
        end
        if @date != 0
          send_data csv_string, filename: "Mbetja-#{@date}.csv"
        else
          send_data csv_string, filename: "Mbetja-#{Date.today}.csv"
        end
      }
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
    all_keys_as_array = ["Data", "Importi", "Emertimi", "Tarif Kodi", "Kodi Artikullit", "Pershkrimi", "Sasia", "Njesia", "Pesha (KG)",
                         "Qmimi Total (€)", "Taksa Doganore (€)", "Akciza (€)", "TVSH (€)", "Gjithsej Taksa (€)"]
    respond_to do |format|
      format.html
      format.json
      format.pdf { render template: "reports/official", pdf: "Official Report - #{Date.today.to_s}", :encoding => 'UTF-8;'}
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << all_keys_as_array
          @gjendja.each do |y, x|
            
            csv << [ y[2].data.strftime("%d/%m/%Y"), y[2].nr_dud, y[1], x[3].article.tarif_kodi, y[0], Article.where(kodi: y[0]).first.pershkrimi_gjate, 
                      '%.2f' % x[0].round(2), x[3].njesia, '%.2f' % x[1].round(2), '%.2f' % x[2].round(2), '%.2f' % x[4].round(2), '%.2f' % x[5].round(2), 
                      '%.2f' % x[6].round(2), '%.2f' % x[7].round(2)]
          end
          csv << ["", "", "", "", "", "Totali", "", "", @totali_pesha.round(4), @totali_qmimi_tot.round(4), @totali_taksa_dogana.round(4), @totali_taksa_akciza.round(4), @totali_taksa_tvsh.round(4), @totali_gjithsej_taksat.round(4)]
        end
        if @date != 0
          send_data csv_string, filename: "Gjendja Zyrtare-#{@date}.csv"
        else
          send_data csv_string, filename: "Gjendja Zyrtare-#{Date.today}.csv"
        end
      }
    end
  end
end
