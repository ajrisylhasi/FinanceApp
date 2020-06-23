module ExportlandesHelper
  def check_exportlande?(expl)
    a = expl.explande_articles.last
    ia = a.import_article.import_gjendja
    
    if a.sasia > ia.sasia || a.pesha > ia.pesha || a.qmimi > ia.qmimi
      flash[:danger] = "Ska mjaftueshem #{a.import_article.article.pershkrimi}"
      false
    else
      flash[:success] = "Done"
      true
    end
  end
  
  def zbritja_expl(expl)
    a = expl.explande_articles.last
    igj = a.import_article.import_gjendja
    igj.sasia -= a.sasia
    igj.qmimi -= a.qmimi
    igj.pesha -= a.pesha
    Subexpl.create(import: igj.import, exportlande: expl, import_gjendja: igj, explande_article: a, sasia: a.sasia, pesha: a.pesha, qmimi: a.qmimi)
    igj.save
    a.save
  end
  
  def veprimi_expl(expl)
    a = expl.explande_articles.last
    igj = a.import_article.import_gjendja
    if check_exportlande?(expl)
      zbritja_expl(expl)
    else
      a.destroy
    end
  end

  def bashko(expl)
    impat = []
    @subsat = []
    subsat_pldh = []
    expl.subexpls.each do |s|
      unless impat.include?(s.import.nr_dud)
        impat.push s.import.nr_dud
      end
    end
    impat.each do |i|
      sub_per_i = expl.subexpls.select { |s| s.import.nr_dud == i }
      subsat_pldh << sub_per_i
    end
    
    subsat_pldh.each do |sub_group|
      hash = {}
      sub_group.each do |s|
        if s.sasia == 0 
          next
        end
        unless hash.keys.include? [s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.exportlande]
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.exportlande]] = [s.sasia, s.pesha, s.qmimi_tot, s.taksa_dogana, s.taksa_akciza, s.taksa_tvsh, s.gjithsej_taksa]
        else
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.exportlande]][0] += s.sasia
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.exportlande]][1] += s.pesha
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.exportlande]][2] += s.qmimi_tot
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.exportlande]][3] += s.taksa_dogana
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.exportlande]][4] += s.taksa_akciza
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.exportlande]][5] += s.taksa_tvsh
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.exportlande]][6] += s.gjithsej_taksa
        end
      end
      @subsat << hash
    end
  end
end
