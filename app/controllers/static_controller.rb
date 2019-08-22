class StaticController < ApplicationController
  
  def gjendja
    refresh_taksa
    if params[:search]
      params[:search] ||= {}
      @date_from = Date.parse(params[:search][:date_from]) rescue 7.days.ago.to_date.to_s
      @date_to = Date.parse(params[:search][:date_to]) rescue Date.today.to_s
      gjendja_bashkimi_search
    end
  end
  
  def mbetja
    
  end
  
  def home 
    # clients = Import.pluck(:client_id).uniq
    # @imports = clients.map do |i|
    #   { name: Client.find(i).kompania, data: Client.group(:kompani)}
    # end
    @imports_taksa = []
    clients = Import.pluck(:client_id).uniq 
    clients.each do |c|
      tot = 0.0
      taksa_tot = Client.find(c).imports.each { |i| tot += i.taksa}
      @imports_taksa.push [Client.find(c).kompania, tot.round(2)]
    end
    @garancions_graph = []
    @vlera_garancioneve = 0
    garancions = Garancion.last(5)
    garancions.each do |c|
      @garancions_graph.push ["Garancioni: #{c.identifikimi}", c.vlera]
    end
    garancionet_valide = Garancion.all.select { |g| g.data_skadimit > Date.current }
    garancionet_valide.each do |g|
      @vlera_garancioneve += g.vlera
    end
    @imports_taksa_pa = []
    imports = Import.last(5)
    imports.each do |c|
      @imports_taksa_pa.push ["Importi: #{c.nr_dud}", c.taksa.round(2)]
    end
    @mbetja_taksa = []
    exports = Export.last(5)
    exports.each do |c|
      @mbetja_taksa.push ["Eksporti: #{c.nr_exportit}", c.mbetja_taksa.round(2)]
    end
    @shitja_produktit = []
    prod = Product.all.sort_by { |pr| pr.shitja}.reverse.first(10)
    prod.each do |p|
      @shitja_produktit.push ["Produkti: #{p.pershkrimi_plote}", p.shitja.round(2)]
    end
    @exports_taksat = []
    clients_e = Export.pluck(:client_id).uniq 
    clients_e.each do |c|
      tot = 0.0
      taksa_tot = Client.find(c).exports.each { |e| tot += e.taksa}
      @exports_taksat.push [Client.find(c).kompania, tot.round(2)]
    end
  end
  
  def reportet
  end
  
  def settings
    home_lajm
  end
  
  def article_present
    if params[:search]
      @articles = Article.where(["pershkrimi LIKE ?", "%#{params[:search]}%"]).or(Article.where(["cast(tarif_kodi as text) LIKE ?", "%#{params[:search]}%"]))
      @articles = @articles.select { |a| a.autorizims.first == Autorizim.first }
      @text = "No Articles with that Name or Taric Code in the Authorisation"
    else
      @articles = []
      @text = "Search for Article in the Authorisation"
    end
  end
end
