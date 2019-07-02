module NormativesHelper
  def check_max?(normative)
    na = normative.normative_articles.last
    max = na.article.autorizim_articles.first.max
    if max == nil
      max = 100
    end
    na.mbetja > max || na.mbetja_peshe > max
  end
  
  def check_prod?(normative)
    if normative.product.autorizims.first == Autorizim.first
      Date.today < Autorizim.first.data_skadimit
    else
      false
    end
  end
  
  def check_full(normative)
    na = normative.normative_articles.last
    
    if check_prod? normative
      if check_max? normative
        max = na.article.autorizim_articles.first.max
        flash[:danger]= "Vlera e mbetjes per #{na.article.pershkrimi} e kalon mbetjen e lejuar ne autorizim - #{max} %"
        na.destroy
      end
    else
      flash[:danger] = "Produkti nuk eshte i autorizuar ose autorizimit i ka skaduar afati"
      na.destroy
    end
  end
end

