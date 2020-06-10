module ApplicationHelper
  include NormativesHelper
  include ImportsHelper
  include ExportsHelper
  include PackingListsHelper
  include ExportlandesHelper
  include StaticHelper
  include MbylljasHelper
  include ReportsHelper
  include SessionsHelper
  
  $gabimet = {}
  $notifications = 0
  
  $garancioni_mbetur = 0
  $taksa_pergjithshme = 0
  $vlera_garancioneve = 0
  
  $lajmerimet = []
  
  def refresh_taksa
    $taksa_pergjithshme = 0
    $vlera_garancioneve = 0
    ImportGjendja.all.each do |i|
      $taksa_pergjithshme += i.gjithsej_taksa
    end
    Sub.all.each do |s|
      $taksa_pergjithshme += s.mbetja_gjithsej_taksa
    end
    if Garancion.all.count > 0
      garancionet_valide = Garancion.all.select { |g| g.data_skadimit > Date.current }
      garancionet_valide.each do |g|
        $vlera_garancioneve += g.vlera
      end
    end
    
    $garancioni_mbetur = $vlera_garancioneve - $taksa_pergjithshme
  end
  
  def lajmerim_garancion
    a = BigDecimal.new($vlera_garancioneve.to_s)
    b = BigDecimal.new(100.to_s)
    c = BigDecimal.new($garancioni_mbetur.to_s)
    garancioni_perqind = b * c / a
    if !(a > 0)
      $lajmerimet.push("Ju nuk keni as nje garancion valid per momentin")
      $notifications += 1
    elsif garancioni_perqind <= 10
      $lajmerimet.push("Ju e keni shfrytezuar #{100 - garancioni_perqind.round(2)}% te garancionit tuaj.")
      $notifications += 1
    end
  end
  
  def lajmerim_garancion_kohe
    garancionet = Garancion.all
    garancionet.each do |g|
      diferenca = g.data_skadimit - Date.today
      if diferenca <= current_user.data_gar && diferenca > 0
        $lajmerimet.push("Garancioni: #{g.identifikimi}, eshte #{diferenca.numerator} dite larg skadimit")
        $notifications += 1 
      elsif diferenca <= 0
        $lajmerimet.push("Garancioni: #{g.identifikimi}, ka skaduar per #{((-1)*diferenca).numerator} dite")
        $notifications += 1 
      end
    end
  end
  
  def lajmerim_autorizim
    data_autorizimit = Autorizim.first.data_skadimit
    diferenca = data_autorizimit - Date.today
    
    if diferenca <= current_user.data_auto && diferenca > 0
      $lajmerimet.push("Autorizimi juaj eshte #{diferenca.numerator} dite larg skadimit")
      $notifications += 1 
    elsif diferenca <= 0
      $lajmerimet.push("Autorizimi juaj ka skaduar qe #{((-1)*diferenca).numerator} dite")
      $notifications += 1 
    end
  end
  
  def refresh_gabimet
    $gabimet = {}
  end
  
  def check_garancion?
    refresh_taksa
    $vlera_garancioneve > $taksa_pergjithshme
  end
  
  def empty_imports
    $notifications = 0
    @empty_imports = []
    @empty_imports_names = []
    @empty_imports = Import.all.select do |i|
      i.empty? && (i.import_articles.count > 0) && !(i.mbylled)
    end
    @empty_imports.each do |i|
      @empty_imports_names.push i.nr_dud 
    end
    $notifications += 1 if @empty_imports.count > 0
  end
  
  def reset_notifications
    $notifications = 0
  end
  
  
  def lajm
    reset_notifications
    $lajmerimet = []
    empty_imports
    lajmerim_garancion
    lajmerim_autorizim
    lajmerim_garancion_kohe
  end
  
  def kompania
    Kompani.first
  end

  def autorizimi
    Autorizim.first
  end

  def enabled?
    autorizimi.data_skadimit > Date.today
  end
  
  def home_lajm
    if current_user != nil
      lajm
    end
  end
  
end