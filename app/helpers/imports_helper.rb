module ImportsHelper
  def refresh_import(import)
    import.import_articles.each do |ia|
      if ia.import_gjendja == nil
        ImportGjendja.create(import: import, import_article: ia, kodi: ia.article.kodi, sasia: ia.sasia, emertimi: ia.emertimi, pesha: ia.pesha, qmimi: ia.qmimi)
      end
    end
    import.save
  end
  
  def bashkimi_importit(import)
    @gjendja = {}
    import.import_gjendjas.each do |i|
      unless @gjendja.key?([i.kodi, i.emertimi, i])
        @gjendja[[i.kodi, i.emertimi, i]] = [i.sasia, i.pesha, i.qmimi_tot, i.taksa_dogana, i.taksa_akciza, i.taksa_tvsh, i.gjithsej_taksa]
      else
        @gjendja[[i.kodi, i.emertimi, i]][0] += i.sasia
        @gjendja[[i.kodi, i.emertimi, i]][1] += i.pesha
        @gjendja[[i.kodi, i.emertimi, i]][2] += i.qmimi_tot
        @gjendja[[i.kodi, i.emertimi, i]][3] += i.taksa_dogana
        @gjendja[[i.kodi, i.emertimi, i]][4] += i.taksa_akciza
        @gjendja[[i.kodi, i.emertimi, i]][5] += i.taksa_tvsh
        @gjendja[[i.kodi, i.emertimi, i]][6] += i.gjithsej_taksa
      end 
    end
    import.gjendja_hash = @gjendja
    import.save
  end
  
  def bashkimi_importit_search(import)
    @gjendja = {}
    import.import_articles.each do |i|
      unless @gjendja.key?([i.kodi, i.emertimi])
        @gjendja[[i.kodi, i.emertimi]] = [i.sasia, i.pesha, i.qmimi, i]
      else
        @gjendja[[i.kodi, i.emertimi]][0] += i.sasia
        @gjendja[[i.kodi, i.emertimi]][1] += i.pesha
        @gjendja[[i.kodi, i.emertimi]][2] += i.qmimi
      end 
    end
    import.gjendja_hash = @gjendja
    import.save
  end
  
  def zbritja_destroy(egj, i, kodi, emertimi, sasia, igj_keqe)
    i_gjat = ImportGjendja.where(import: i).where(emertimi: emertimi).where(kodi: kodi)
    sas = egj.sasia
    mbt = egj.mbetja
    psh = egj.pesha
    mb_psh = egj.mbetja_peshe
    qm = egj.qmimi
    mb_qm = egj.mbetja_qmimi
    i_gjat.each do |igj|
      if !(sas > 0)
        break
      end
      if !(igj.sasia > 0) || igj == igj_keqe
        next
      end
      if igj.sasia >= (sas + mbt) && igj.pesha >= (psh + mb_psh) && igj.qmimi >= (qm + mb_qm)
        Sub.create(import: i, export: egj.export, import_gjendja: igj, export_gjendja: egj, sasia: sas, mbetja: mbt, pesha: psh, mbetja_peshe: mb_psh, qmimi: qm, mbetja_qmimi: mb_qm)
        igj.sasia -= (sas + mbt)
        igj.pesha -= (psh + mb_psh)
        igj.qmimi -= (qm + mb_qm) 
        igj.save
        sas = 0
        mbt = 0
        psh = 0
        mb_psh = 0
        qm = 0
        mb_qm = 0
      else
        vlera_sas = (igj.sasia * sas) / (sas + mbt)
        vlera_mbt = (igj.sasia * mbt) / (sas + mbt)
        vlera_psh = (igj.pesha * psh) / (psh + mb_psh)
        vlera_mb_psh = (igj.pesha * mb_psh) / (psh + mb_psh)
        vlera_qm = (igj.qmimi * qm) / (qm + mb_qm)
        vlera_mb_qm = (igj.qmimi * mb_qm) / (qm + mb_qm)
        Sub.create(import: i, export: egj.export, import_gjendja: igj, export_gjendja: egj, sasia: vlera_sas, mbetja: vlera_mbt, pesha: psh, mbetja_peshe: mb_psh, qmimi: vlera_qm, mbetja_qmimi: vlera_mb_qm)
        sas -= vlera_sas
        mbt -= vlera_mbt
        psh -= vlera_psh
        mb_psh -= vlera_mb_psh
        qm -= vlera_qm
        mb_qm -= vlera_mb_qm
        igj.sasia = 0
        igj.save
      end
    end
    egj.sasia = sas
    egj.mbetja = mbt
    egj.pesha = psh
    egj.mbetja_peshe = mb_psh
    egj.qmimi = qm
    egj.mbetja_qmimi = mb_qm
    egj.save
    bashkimi_importit(i)
    refresh_gjendja
  end
  

  def vlera_autorizimit_garancion(import)
    if Autorizim.first.data_skadimit <= Date.current && !check_garancion?
      flash[:danger] = "Ka kaluar data e skadimit per Autorizimin me kete Artikull dhe vlera e garancioneve ka kaluar."
      import.import_articles.last.destroy
      bashkimi_importit(import)
    elsif Autorizim.first.data_skadimit <= Date.current
      flash[:danger] = "Ka kaluar data e skadimit per Autorizimin me kete Artikull"
      import.import_articles.last.destroy
      bashkimi_importit(import)
    elsif !check_garancion?
      flash[:danger] = "Vlera e garancionit kalon"
      import.import_articles.last.destroy
      bashkimi_importit(import)
    else
      refresh_import(@import)
    end
  end
  
end
