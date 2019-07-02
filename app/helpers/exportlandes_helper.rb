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
end
