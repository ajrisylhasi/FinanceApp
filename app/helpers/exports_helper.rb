module ExportsHelper
  
  def refresh_export(export)
    export.export_products.each do |ep|

      if ep.export_gjendjas.count == 0 && ep.valid?
        hash = {}
        ep.normative.normative_articles.each do |na|
          unless hash.key?(na.article.kodi)
            hash[na.article.kodi] = [na.sasia_neto * ep.sasia, na.mbetja_ne_sasi * ep.sasia, na.pesha_neto * ep.sasia, na.mbetja_ne_peshe * ep.sasia, 0, 0]
          else
            hash[na.article.kodi][0] += na.sasia_neto * ep.sasia
            hash[na.article.kodi][1] += na.mbetja_ne_sasi * ep.sasia
            hash[na.article.kodi][2] += na.pesha_neto * ep.sasia
            hash[na.article.kodi][3] += na.mbetja_ne_peshe * ep.sasia
          end
        end
        hash.each do |a, b|
          ExportGjendja.create(export: export, export_product: ep, kodi: a, sasia: b[0], mbetja: b[1], pesha: b[2], mbetja_peshe: b[3], qmimi: b[4], mbetja_qmimi: b[5])
        end
      end
    end
  end
  
  def bashkimi_exportit(export)
    @gjendja = {}
    export.export_gjendjas.each do |e|
      unless @gjendja.key?(e.kodi)
        @gjendja[e.kodi] = [e.sasia, e.mbetja, e.pesha, e.mbetja_peshe]
      else
        @gjendja[e.kodi][0] += e.sasia
        @gjendja[e.kodi][1] += e.mbetja
        @gjendja[e.kodi][2] += e.pesha
        @gjendja[e.kodi][3] += e.mbetja_peshe
      end
    end
    export.gjendja_hash = @gjendja
    export.save
  end
  
  def zbritja(export)
    export.export_gjendjas.each do |egj|
      i_jat_paraprak = Import.select { |i| i.client_id == egj.export.client_id }.sort_by { |i| [i.data, i.id]}
      i_jat = i_jat_paraprak.select { |i| i.import_gjendjas.where(kodi: egj.kodi).count != 0 && i.client == egj.export.client}
      i_jat.each do |i|
        igj_jat = i.import_gjendjas.where(kodi: egj.kodi)
        
        sas = egj.sasia 
        mbt = egj.mbetja
        psh = egj.pesha
        mb_psh = egj.mbetja_peshe
        qm = 0
        mb_qm = 0
        igj_jat.each do |igj|
          if !(sas > 0)
            break
          end
          if !(igj.sasia > 0) 
            next
          end
          qm_njs = igj.import_article.qmimi_njesi_norm
          qm = qm_njs * sas
          mb_qm = qm_njs * mbt
          if igj.sasia >= (sas + mbt) && igj.pesha >= (psh + mb_psh) && igj.qmimi >= (qm + mb_qm)
            Sub.create(import: i, export: export, import_gjendja: igj, export_gjendja: egj, sasia: sas, mbetja: mbt, pesha: psh, mbetja_peshe: mb_psh, qmimi: qm, mbetja_qmimi: mb_qm)
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
            Sub.create(import: i, export: export, import_gjendja: igj, export_gjendja: egj, sasia: vlera_sas, mbetja: vlera_mbt, pesha: vlera_psh, 
                                                                          mbetja_peshe: vlera_mb_psh, qmimi: vlera_qm, mbetja_qmimi: vlera_mb_qm)
            sas -= vlera_sas
            mbt -= vlera_mbt
            psh -= vlera_psh
            mb_psh -= vlera_mb_psh
            qm -= vlera_qm
            mb_qm -= vlera_mb_qm
            igj.sasia = 0
            igj.pesha = 0 
            igj.qmimi = 0
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
      end
    end
  end
  
  def check_export?(export)
    $gabimet = []
    refresh_gjendja_specific(export.client)
    check = true
    hash = {}
    e = export.export_products.last
    if e.product.autorizims.first != Autorizim.first
      check = false
      $gabimet.push "Produkti #{e.product.pershkrimi} nuk eshte i autorizuar." 
    elsif !(Autorizim.first.data_skadimit > Date.current)
      check = false
      $gabimet.push "Data e autorizimit ka skaduar."
    end
    e.export_gjendjas.each do |egj|
      qmimi = 0
      mbetja = 0
      i_jat_paraprak = Import.select { |i| i.client_id == egj.export.client_id }
      i_jat = i_jat_paraprak.select { |i| i.import_gjendjas.where(kodi: egj.kodi).count != 0 }.sort_by { |i| i.data }
      i_jat.each do |i|
        igj_jat = i.import_gjendjas.where(kodi: egj.kodi)
        sas = egj.sasia 
        mbt = egj.mbetja
        psh = egj.pesha
        mb_psh = egj.mbetja_peshe
        qm = 0
        mb_qm = 0
        igj_jat.each do |igj|
          if !(sas > 0)
            break
          end
          if !(igj.sasia > 0) 
            next
          end
          qm_njs = igj.import_article.qmimi_njesi_norm
          qm = qm_njs * sas
          mb_qm = qm_njs * mbt
          if igj.sasia >= (sas + mbt) && igj.pesha >= (psh + mb_psh) && igj.qmimi >= (qm + mb_qm)
            igj.sasia -= (sas + mbt)
            igj.pesha -= (psh + mb_psh)
            igj.qmimi -= (qm + mb_qm) 
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
            sas -= vlera_sas
            mbt -= vlera_mbt
            psh -= vlera_psh
            mb_psh -= vlera_mb_psh
            qm -= vlera_qm
            mb_qm -= vlera_mb_qm
            igj.sasia = 0
            igj.pesha = 0 
            igj.qmimi = 0
          end
          qmimi += qm
          mbetja += mb_qm
        end
      end
      egj.qmimi = qmimi
      egj.mbetja_qmimi = mbetja
      egj.save
    end
    e.export_gjendjas.each do |egj|
      unless hash.key?(egj.kodi)
        hash[egj.kodi] = [egj.sasia + egj.mbetja, egj.pesha + egj.mbetja_peshe, egj.qmimi + egj.mbetja_qmimi]
      else
        hash[egj.kodi][0] += egj.sasia + egj.mbetja
        hash[egj.kodi][1] += egj.pesha + egj.mbetja_pesha
        hash[egj.kodi][2] += egj.qmimi + egj.mbetja_qmimi
      end
    end
    
    hash.each do |p_e, sasia_e|
      unless $hash_specific.include? p_e
        check = false
        $gabimet.push "Nuk ka fare #{Article.where(kodi: p_e).first.pershkrimi} (#{p_e}) te importuar per #{export.client.kompania}. Duhet edhe #{sasia_e[0]} #{Article.where(kodi: p_e).first.njesia}" 
      else
        if $hash_specific[p_e][0] < sasia_e[0] 
          check = false
          $gabimet.push "Nuk ka mjaftueshem #{Article.where(kodi: p_e).first.pershkrimi} (#{p_e}) te importuar per #{export.client.kompania}. Duhet edhe #{sasia_e[0] - $hash_specific[p_e][0]} #{Article.where(kodi: p_e).first.njesia}" 
        elsif $hash_specific[p_e][1] < sasia_e[1]
          check = false
          $gabimet.push "Nuk ka mjaftueshem peshe per #{Article.where(kodi: p_e).first.pershkrimi} (#{p_e}) te importuar per #{export.client.kompania}. Duhet edhe #{sasia_e[1] - $hash_specific[p_e][1]} Kg" 
        elsif $hash_specific[p_e][2] < sasia_e[2]
          check = false
          $gabimet.push "Qmimi per #{Article.where(kodi: p_e).first.pershkrimi} (#{p_e}) te importuar nuk eshte i mjaftueshem per #{export.client.kompania}. Duhet edhe #{sasia_e[2] - $hash_specific[p_e][2]} €"
        end
      end
    end
    check
  end
  
  def refresh_pack(export)
    hash = {}
    export.export_products.each do |ep|
      if hash.keys.include? ep.product.pershkrimi
        hash[ep.product.pershkrimi] += ep.sasia
      else
        hash[ep.product.pershkrimi] = ep.sasia
      end
    end
    export.pack_gjendja = hash
  end 
  
  def zbritja_pack_e(export)
    refresh_pack(export)
    refresh_pack_p(export.packing_list)
    export.pack_gjendja.each do |prod, sas|
      if !(sas > 0) 
        next
      end
      export.pack_not.push "Hala sjon rahatu krejt produktet #{prod} - #{sas} tjere tpa rahatun"
      export.packing_list.pack_gjendja.each do |prod_p, sas_p|
        if !(sas_p > 0)
          next
        end
        if prod == prod_p
          if sas > sas_p
            sas -= sas_p
            sas_p = 0
            export.pack_not.push "Hala sjon rahatu krejt produktet #{prod_p} - #{sas} tjere tpa rahatun"
          elsif sas_p > sas
            sas_p -= sas
            sas = 0
            export.pack_not.push "Ka hala van per #{prod_p} - #{sas_p} tjere i nxan"
          else
            sas_p = 0
            sas = 0
            export.pack_not.push "Fiks jon rahatu #{prod_p}"
          end
        end
      end
    end
    export.save
    export.packing_list.save
  end
  
  def veprimi(export)
    if check_export?(export)
      zbritja(export)
      export.save
    else
      export.export_products.last.destroy
      bashkimi_exportit(export)
    end
  end
  
  def bashkimi_sub(export)
    subsat_pldh = []
    @subsat = []
    impat = []
    export.subs.each do |s|
      unless impat.include?(s.import.nr_dud)
        impat.push s.import.nr_dud
      end
    end
    impat.each do |i|
      sub_per_i = export.subs.select { |s| s.import.nr_dud == i }
      subsat_pldh << sub_per_i
    end
    
    subsat_pldh.each do |sub_group|
      hash = {}
      sub_group.each do |s|
        if s.sasia == 0 
          next
        end
        unless hash.keys.include? [s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]] = [s.sasia, s.pesha, s.qmimi_tot, s.taksa_dogana, s.taksa_akciza, s.taksa_tvsh, s.gjithsej_taksa]
        else
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][0] += s.sasia
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][1] += s.pesha
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][2] += s.qmimi_tot
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][3] += s.taksa_dogana
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][4] += s.taksa_akciza
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][5] += s.taksa_tvsh
          hash[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][6] += s.gjithsej_taksa
        end
      end
      @subsat << hash
    end
  end
end
