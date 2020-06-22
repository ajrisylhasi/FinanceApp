module ReportsHelper
  
  def gjendja_bashkimi
    @gjendja = {}
    ImportGjendja.all.each do |i|
      if i.import.mbylled == true
        next
      end
      if @gjendja.keys.include? [i.kodi, i.emertimi, i.import]
        @gjendja[[i.kodi, i.emertimi, i.import]][0] += i.sasia
        @gjendja[[i.kodi, i.emertimi, i.import]][1] += i.pesha
        @gjendja[[i.kodi, i.emertimi, i.import]][2] += i.qmimi_tot
        @gjendja[[i.kodi, i.emertimi, i.import]][4] += i.taksa_dogana
        @gjendja[[i.kodi, i.emertimi, i.import]][5] += i.taksa_akciza
        @gjendja[[i.kodi, i.emertimi, i.import]][6] += i.taksa_tvsh
        @gjendja[[i.kodi, i.emertimi, i.import]][7] += i.gjithsej_taksa
      else
        @gjendja[[i.kodi, i.emertimi, i.import]] = [i.sasia, i.pesha, i.qmimi_tot, i.import_article, i.taksa_dogana, i.taksa_akciza, i.taksa_tvsh, i.gjithsej_taksa]
      end
    end
    @gjendja.reject! { |k, v| !(v[0] > 0)} 
    @gjendja = @gjendja.sort_by {|y, x| [y[2].data, y[2].id, y[1].to_i] }
    @totali_pesha = 0
    @totali_qmimi_tot = 0
    @totali_taksa_dogana = 0
    @totali_taksa_akciza = 0
    @totali_taksa_tvsh = 0
    @totali_gjithsej_taksat = 0
    @imports = []
    @gjendja.each do |k, v|
      @totali_pesha += v[1]
      @totali_qmimi_tot += v[2]
      @totali_taksa_dogana += v[4]
      @totali_taksa_akciza += v[5]
      @totali_taksa_tvsh += v[6]
      @totali_gjithsej_taksat += v[7]
      unless @imports.include? k[2]
        @imports.push k[2]
      end
    end
  end
  
  def refresh_gjendja
    $hash_specific = {}
    Import.all.each do |i|
      bashkimi_importit(i)
      i.gjendja_hash.each do |a, s|
        unless $hash_specific.keys.include? a[0]
          $hash_specific[a[0]] = s
        else
          $hash_specific[a[0]][0] += s[0]
          $hash_specific[a[0]][1] += s[1]
          $hash_specific[a[0]][2] += s[2]
          $hash_specific[a[0]][3] += s[3]
          $hash_specific[a[0]][4] += s[4]
          $hash_specific[a[0]][5] += s[5]
        end
      end
    end
  end
  
  def mbetja_bashkimi
    @hash_mbetja = {}
    Sub.all.each do |s|
      if s.mbetja == 0 
        next
      end
      unless @hash_mbetja.keys.include? [s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]
        @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]] = [s.mbetja,
          s.mbetja_peshe, s.mbetja_qmimi, s.mbetja_qmimi_tot, s.mbetja_taksa_dogana, s.mbetja_taksa_akciza, s.mbetja_taksa_tvsh,
          s.mbetja_gjithsej_taksa]
      else
        @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][0] += s.mbetja
        @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][1] += s.mbetja_peshe
        @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][2] += s.mbetja_qmimi
        @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][3] += s.mbetja_qmimi_tot
        @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][4] += s.mbetja_taksa_dogana
        @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][5] += s.mbetja_taksa_akciza
        @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][6] += s.mbetja_taksa_tvsh
        @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][7] += s.mbetja_gjithsej_taksa
      end
    end
  end
  
  def mbetja_bashkimi_search
    @hash_mbetja = {}
    data_funit = 0 
    data_im = Import.all.sort_by { |e| e.data}.last.data
    data_ex = Export.all.sort_by { |e| e.data}.last.data
    if data_im > data_ex
      data_funit = data_im
    else
      data_funit = data_ex
    end
    if @date == 0
      mbetja_bashkimi
    elsif (@date - data_funit) >= 0
      mbetja_bashkimi
    else
      array = Sub.select { |s| s.export.data <= @date }
      array.each do |s|
        if s.mbetja == 0 
          next
        end
        unless @hash_mbetja.keys.include? [s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]
          @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]] = [s.mbetja,
            s.mbetja_peshe, s.mbetja_qmimi, s.qmimi_tot, s.mbetja_taksa_dogana, s.mbetja_taksa_akciza, s.mbetja_taksa_tvsh,
            s.mbetja_gjithsej_taksa]
        else
          @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][0] += s.mbetja
          @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][1] += s.mbetja_peshe
          @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][2] += s.mbetja_qmimi
          @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][3] += s.mbetja_qmimi_tot
          @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][4] += s.mbetja_taksa_dogana
          @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][5] += s.mbetja_taksa_akciza
          @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][6] += s.mbetja_taksa_tvsh
          @hash_mbetja[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export]][7] += s.mbetja_gjithsej_taksa
        end
      end
    end
  end
  
  def refresh_mbetja_export(export)
    @hash_mbetja_export = {}
    export.subs.each do |s|
      if s.mbetja == 0 
        next
      end
      unless @hash_mbetja_export.keys.include? [s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export, s]
        @hash_mbetja_export[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export, s]] = [s.mbetja, s.mbetja_peshe, s.mbetja_qmimi]
      else
        @hash_mbetja_export[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export, s]][0] += s.mbetja
        @hash_mbetja_export[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export, s]][1] += s.mbetja_peshe
        @hash_mbetja_export[[s.import_gjendja.kodi, s.import_gjendja.emertimi, s.import, s.export, s]][2] += s.mbetja_qmimi
      end
    end
  end
  
  def refresh_gjendja_specific(client)
    $hash_specific = {}
    Import.where(client: client).all.each do |i|
      next if i.skaduar?
      
      bashkimi_importit(i)
      i.gjendja_hash.each do |a, s|
        unless $hash_specific.keys.include? a[0]
          $hash_specific[a[0]] = s
        else
          $hash_specific[a[0]][0] += s[0]
          $hash_specific[a[0]][1] += s[1]
          $hash_specific[a[0]][2] += s[2]
          $hash_specific[a[0]][3] += s[3]
          $hash_specific[a[0]][4] += s[4]
          $hash_specific[a[0]][5] += s[5]
        end
      end
    end
  end
  
  def gjendja_bashkimi_search 
    @gjendja = {}
    if Import.count == 0 || Export.count == 0 || Import.all.where(mbylled: false).count == 0
      gjendja_bashkimi
    else
      data_funit = 0 
      data_im = Import.all.where(mbylled: false).sort_by { |e| e.data}.last.data
      data_ex = Export.all.sort_by { |e| e.data}.last.data
      if data_im > data_ex
        data_funit = data_im
      else
        data_funit = data_ex
      end
      if @date == 0
        gjendja_bashkimi
      elsif (@date - data_funit) >= 0
        gjendja_bashkimi
      else
        impat = Import.all.select {|i| i.data <= @date }
        expat = Export.all.select {|e| e.data <= @date }
        hash_gjendja = {}
        impat.each do |i|
          bashkimi_importit_search(i)
          i.gjendja_hash.each do |a, s|
            unless hash_gjendja.keys.include? [a[0], a[1], i]
              hash_gjendja[[a[0], a[1], i]] = s
            else
              hash_gjendja[[a[0], a[1], i]][0] += s[0]
              hash_gjendja[[a[0], a[1], i]][1] += s[1]
              hash_gjendja[[a[0], a[1], i]][2] += s[2]
            end
          end
        end
        
        expat.each do |export|
          export.export_products.each do |ep|
            hash = {}
            ep.normative.normative_articles.each do |na|
              unless hash.key?(na.article.kodi)
                hash[na.article.kodi] = [na.sasia_neto * ep.sasia, na.mbetja_ne_sasi * ep.sasia, na.pesha_neto * ep.sasia, na.mbetja_ne_peshe * ep.sasia]
              else
                hash[na.article.kodi][0] += na.sasia_neto * ep.sasia
                hash[na.article.kodi][1] += na.mbetja_ne_sasi * ep.sasia
                hash[na.article.kodi][2] += na.pesha_neto * ep.sasia
                hash[na.article.kodi][3] += na.mbetja_ne_peshe * ep.sasia
              end
            end
            hash.each do |u, b|
              sas = b[0] 
              mbt = b[1]
              psh = b[2]
              mb_psh = b[3]
              qm = 0
              mb_qm = 0
              if !(sas > 0)
                break
              end
              hash_gjendja.select {|e, n| e[0] == u && n[0] > 0 && e[2].client == export.client}.sort_by {|e, n| e[2].data }.each do |a, s|
                if !(s[0] > 0) 
                  next  
                end
                qm_njs = s[3].qmimi_njesi_norm
                qm = qm_njs * sas
                mb_qm = qm_njs * mbt
                if s[0] >= (sas + mbt) && s[1] >= (psh + mb_psh) && s[2] >= (qm + mb_qm)
                  hash_gjendja[a][0] -= (sas + mbt)
                  hash_gjendja[a][1] -= (psh + mb_psh)
                  hash_gjendja[a][2] -= (qm + mb_qm)
                  sas = 0
                  mbt = 0
                  psh = 0
                  mb_psh = 0
                  qm = 0
                  mb_qm = 0
                else
                  vlera_sas = (s[0] * sas) / (sas + mbt)
                  vlera_mbt = (s[0] * mbt) / (sas + mbt)
                  vlera_psh = (s[1] * psh) / (psh + mb_psh)
                  vlera_mb_psh = (s[1] * mb_psh) / (psh + mb_psh)
                  vlera_qm = (s[2] * qm) / (qm + mb_qm)
                  vlera_mb_qm = (s[2] * mb_qm) / (qm + mb_qm)
                  sas -= vlera_sas
                  mbt -= vlera_mbt
                  psh -= vlera_psh
                  mb_psh -= vlera_mb_psh
                  qm -= vlera_qm
                  mb_qm -= vlera_mb_qm
                  hash_gjendja[a][0] = 0
                  hash_gjendja[a][1] = 0 
                  hash_gjendja[a][2] = 0
                end
              end
              hash[u][0] = sas
              hash[u][1]= mbt
              hash[u][2]= psh
              hash[u][3]= mb_psh
            end
          end
        end
        hash_gjendja.reject! { |k, v| v[0] == 0} 
        
        hash_gjendja.each do |u, s|
          sas = s[0]
          psh = s[1]
          qm = s[2]
          i = s[3]
          transport = (qm * i.transport) / i.qmimi
          qmimi_tot = qm + transport
          taksa_dogana = (i.dogana * qmimi_tot) / 100
          if i.lloji_akcizes == "Pa akcize"
            taksa_akciza = 0
          elsif i.lloji_akcizes == "%"
            a = i.akciza
            b = 100
            c = qmimi_tot
            d = taksa_dogana
            taksa_akciza = a*(c+d)/b
          elsif i.lloji_akcizes == "€/Kg"
            a = i.akciza
            c = psh
            taksa_akciza = a*c
          elsif i.lloji_akcizes == "€/Njesi"
            a = i.akciza
            c = sas
            taksa_akciza = a*c
          end
          a = i.tvsh
          b = 100
          c = qmimi_tot
          d = taksa_akciza
          e = taksa_dogana
          taksa_tvsh = a*(c+d+e)/b
          a = taksa_dogana
          b = taksa_tvsh
          c = taksa_akciza
          gjithsej_taksa = a + b + c
          # <========================>
            hash_gjendja[u][2] = qmimi_tot
            hash_gjendja[u][4] = taksa_dogana
            hash_gjendja[u][5] = taksa_akciza
            hash_gjendja[u][6] = taksa_tvsh
            hash_gjendja[u][7] = gjithsej_taksa
          # <========================>
        end
        @gjendja = hash_gjendja.sort_by {|y, x| [y[2].data, y[2].id, y[1].to_i] }
      end
    end
    @gjendja.reject! { |k, v| !(v[0] > 0)} 
    if @import != 0
      @gjendja.reject! { |k, v| k[2].id != @import.id }
    end
    @imports = []
    @totali_pesha = 0
    @totali_qmimi_tot = 0
    @totali_taksa_dogana = 0
    @totali_taksa_akciza = 0
    @totali_taksa_tvsh = 0
    @totali_gjithsej_taksat = 0
    @gjendja.each do |k, v|
      @totali_pesha += v[1]
      @totali_qmimi_tot += v[2]
      @totali_taksa_dogana += v[4]
      @totali_taksa_akciza += v[5]
      @totali_taksa_tvsh += v[6]
      @totali_gjithsej_taksat += v[7]
      unless @imports.include? k[2]
        @imports.push k[2]
      end
    end
  end
  
  def import_search
    impat = Import.where('data BETWEEN ? and ?', @date_from, @date_to)
    @list = []
    if @client == 0 
      if @article == 0
        impat.each do |i|
          i.import_articles.each do |ep|
            @list.push(ep)
          end
        end
      else
        impat.each do |i|
          i.import_articles.each do |ep|
            if ep.article == @article
              @list.push(ep)
            end
          end
        end
      end
    else
      impat.each do |i|
        if i.client == @client
          if @article == 0
            i.import_articles.each do |ep|
              @list.push(ep)
            end
          else
            i.import_articles.each do |ep|
              if ep.article == @article
                @list.push(ep)
              end
            end
          end
        end
      end
    end
  end
  
  def product_search
    expat = Export.where('data BETWEEN ? and ?', @date_from, @date_to)
    @list = []
    if @client == 0 
      if @product == 0
        expat.each do |e|
          e.export_products.each do |ep|
            @list.push(ep)
          end
        end
      else
        expat.each do |e|
          e.export_products.each do |ep|
            if ep.product == @product
              @list.push(ep)
            end
          end
        end
      end
    else
      expat.each do |e|
        if e.client == @client
          if @product == 0
            e.export_products.each do |ep|
              @list.push(ep)
            end
          else
            e.export_products.each do |ep|
              if ep.product == @product
                @list.push(ep)
              end
            end
          end
        end
      end
    end
  end
  
  def product_search_export(export)
    @list = []
    export.export_products.each do |ep|
      @list.push(ep)
    end
  end

  def product_search_exportlande(export)
    @list = []
    export.explande_articles.each do |ea|
      @list.push(ea)
    end
  end
  
  
  def official_bashkimi_search 
    @gjendja = {}
    if Import.count == 0 || Export.count == 0
      official_bashkimi
    else
      data_funit = 0 
      data_im = Import.all.sort_by { |e| [e.data, e.id]}.last.data
      data_ex = Export.all.sort_by { |e| [e.data, e.id]}.last.data
      if data_im > data_ex
        data_funit = data_im
      else
        data_funit = data_ex
      end
      if Mbyllja.any? 
        data_mb = Mbyllja.all.sort_by { |e| [e.data, e.id]}.last.data
        if data_mb > data_funit
          data_funit = data_mb
        end
      end
      if @date == 0
        official_bashkimi
      elsif (@date - data_funit) >= 0
        official_bashkimi
      else
        impat = Import.all.select {|i| i.data <= @date }
        expat = Export.all.select {|e| e.data <= @date }
        hash_gjendja = {}
        impat.each do |i|
          bashkimi_importit_search(i)
          i.gjendja_hash.each do |a, s|
            unless hash_gjendja.keys.include? [a[0], a[1], i]
              hash_gjendja[[a[0], a[1], i]] = s
              hash_gjendja[[a[0], a[1], i]][4] = 0
              hash_gjendja[[a[0], a[1], i]][5] = 0
              hash_gjendja[[a[0], a[1], i]][6] = 0
            else
              hash_gjendja[[a[0], a[1], i]][0] += s[0]
              hash_gjendja[[a[0], a[1], i]][1] += s[1]
              hash_gjendja[[a[0], a[1], i]][2] += s[2]
            end
          end
        end
        
        expat.each do |export|
          export.export_products.each do |ep|
            hash = {}
            ep.normative.normative_articles.each do |na|
              unless hash.key?(na.article.kodi)
                hash[na.article.kodi] = [na.sasia_neto * ep.sasia, na.mbetja_ne_sasi * ep.sasia, na.pesha_neto * ep.sasia, na.mbetja_ne_peshe * ep.sasia]
              else
                hash[na.article.kodi][0] += na.sasia_neto * ep.sasia
                hash[na.article.kodi][1] += na.mbetja_ne_sasi * ep.sasia
                hash[na.article.kodi][2] += na.pesha_neto * ep.sasia
                hash[na.article.kodi][3] += na.mbetja_ne_peshe * ep.sasia
              end
            end
            hash.each do |u, b|
              sas = b[0] 
              mbt = b[1]
              psh = b[2]
              mb_psh = b[3]
              qm = 0
              mb_qm = 0
              if !(sas > 0)
                break
              end
              hash_gjendja.select {|e, n| e[0] == u && n[0] > 0 && e[2].client == export.client}.sort_by {|e, n| [e[2].data, e[2].id] }.each do |a, s|
                if !(s[0] > 0) 
                  next  
                end 
                qm_njs = s[3].qmimi_njesi_norm
                qm = qm_njs * sas
                mb_qm = qm_njs * mbt
                if s[0] >= (sas + mbt) && s[1] >= (psh + mb_psh) && s[2] >= (qm + mb_qm)
                  hash_gjendja[a][0] -= (sas + mbt)
                  hash_gjendja[a][1] -= (psh + mb_psh)
                  hash_gjendja[a][2] -= (qm + mb_qm)
                  hash_gjendja[a][4] += mbt
                  hash_gjendja[a][5] += mb_psh
                  hash_gjendja[a][6] += mb_qm
                  sas = 0
                  mbt = 0
                  psh = 0
                  mb_psh = 0
                  qm = 0
                  mb_qm = 0
                else
                  vlera_sas = (s[0] * sas) / (sas + mbt)
                  vlera_mbt = (s[0] * mbt) / (sas + mbt)
                  vlera_psh = (s[1] * psh) / (psh + mb_psh)
                  vlera_mb_psh = (s[1] * mb_psh) / (psh + mb_psh)
                  vlera_qm = (s[2] * qm) / (qm + mb_qm)
                  vlera_mb_qm = (s[2] * mb_qm) / (qm + mb_qm)
                  sas -= vlera_sas
                  mbt -= vlera_mbt
                  psh -= vlera_psh
                  mb_psh -= vlera_mb_psh
                  qm -= vlera_qm
                  mb_qm -= vlera_mb_qm
                  hash_gjendja[a][0] = 0
                  hash_gjendja[a][1] = 0 
                  hash_gjendja[a][2] = 0
                  hash_gjendja[a][4] += vlera_mbt
                  hash_gjendja[a][5] += vlera_mb_psh
                  hash_gjendja[a][6] += vlera_mb_qm
                end
              end
              hash[u][0] = sas
              hash[u][1]= mbt
              hash[u][2]= psh
              hash[u][3]= mb_psh
            end
          end
        end
        
        hash_gjendja.each do |u, s|
          sas = s[0] + s[4]
          psh = s[1] + s[5]
          qm = s[2] + s[6]
          i = s[3]
          if u[2].mbylled
            unless u[2].mbyllja.data > @date
              sas -= s[4]
              psh -= s[5]
              qm -= s[6]
            end
          end
          transport = (qm * i.transport) / i.qmimi
          qmimi_tot = qm + transport
          taksa_dogana = (i.dogana * qmimi_tot) / 100
          if i.lloji_akcizes == "Pa akcize"
            taksa_akciza = 0
          elsif i.lloji_akcizes == "%"
            a = i.akciza
            b = 100
            c = qmimi_tot
            d = taksa_dogana
            taksa_akciza = a*(c+d)/b
          elsif i.lloji_akcizes == "€/Kg"
            a = i.akciza
            c = psh
            taksa_akciza = a*c
          elsif i.lloji_akcizes == "€/Njesi"
            a = i.akciza
            c = sas
            taksa_akciza = a*c
          end
          a = i.tvsh
          b = 100
          c = qmimi_tot
          d = taksa_akciza
          e = taksa_dogana
          taksa_tvsh = a*(c+d+e)/b
          a = taksa_dogana
          b = taksa_tvsh
          c = taksa_akciza
          gjithsej_taksa = a + b + c
          # <========================>
            hash_gjendja[u][0] = sas
            hash_gjendja[u][1] = psh
            hash_gjendja[u][2] = qmimi_tot
            hash_gjendja[u][4] = taksa_dogana
            hash_gjendja[u][5] = taksa_akciza
            hash_gjendja[u][6] = taksa_tvsh
            hash_gjendja[u][7] = gjithsej_taksa
          # <========================>
        end
        hash_gjendja.reject! { |k, v| v[0] == 0} 
        @gjendja = hash_gjendja.sort_by {|y, x| [y[2].data, y[2].id, y[1].to_i] }
      end
    end
    if @import != 0
      @gjendja.reject! { |k, v| k[2].id != @import.id }
    end
    @imports = []
    @totali_pesha = 0
    @totali_qmimi_tot = 0
    @totali_taksa_dogana = 0
    @totali_taksa_akciza = 0
    @totali_taksa_tvsh = 0
    @totali_gjithsej_taksat = 0
    @gjendja.each do |k, v|
      @totali_pesha += v[1]
      @totali_qmimi_tot += v[2]
      @totali_taksa_dogana += v[4]
      @totali_taksa_akciza += v[5]
      @totali_taksa_tvsh += v[6]
      @totali_gjithsej_taksat += v[7]
      unless @imports.include? k[2]
        @imports.push k[2]
      end
    end
  end
  
  def official_bashkimi
    @gjendja = {}
    ImportGjendja.all.each do |i|
      if i.import.mbylled == true
        next
      end
      mbt = 0
      mb_psh = 0
      mb_qm = 0
      i.subs.each do |s|
        mbt += s.mbetja
        mb_psh += s.mbetja_peshe
        mb_qm += s.mbetja_qmimi
      end

      sas = i.sasia + mbt
      psh = i.pesha + mb_psh
      qm = i.qmimi + mb_qm
      ia = i.import_article
      transport = (qm * ia.transport) / ia.qmimi
      qmimi_tot = qm + transport
      taksa_dogana = (ia.dogana * qmimi_tot) / 100
      if ia.lloji_akcizes == "Pa akcize"
        taksa_akciza = 0
      elsif ia.lloji_akcizes == "%"
        a = ia.akciza
        b = 100
        c = qmimi_tot
        d = taksa_dogana
        taksa_akciza = a*(c+d)/b
      elsif ia.lloji_akcizes == "€/Kg"
        a = ia.akciza
        c = psh
        taksa_akciza = a*c
      elsif ia.lloji_akcizes == "€/Njesi"
        a = ia.akciza
        c = sas
        taksa_akciza = a*c
      end
      a = ia.tvsh
      b = 100
      c = qmimi_tot
      d = taksa_akciza
      e = taksa_dogana
      taksa_tvsh = a*(c+d+e)/b
      a = taksa_dogana
      b = taksa_tvsh
      c = taksa_akciza
      gjithsej_taksa = a + b + c
      if @gjendja.keys.include? [i.kodi, i.emertimi, i.import]
        @gjendja[[i.kodi, i.emertimi, i.import]][0] += sas
        @gjendja[[i.kodi, i.emertimi, i.import]][1] += psh
        @gjendja[[i.kodi, i.emertimi, i.import]][2] += qmimi_tot
        @gjendja[[i.kodi, i.emertimi, i.import]][4] += taksa_dogana
        @gjendja[[i.kodi, i.emertimi, i.import]][5] += taksa_akciza
        @gjendja[[i.kodi, i.emertimi, i.import]][6] += taksa_tvsh
        @gjendja[[i.kodi, i.emertimi, i.import]][7] += gjithsej_taksa
      else
        @gjendja[[i.kodi, i.emertimi, i.import]] = [sas, psh, qmimi_tot, i.import_article, taksa_dogana, taksa_akciza, taksa_tvsh, gjithsej_taksa]
      end
    end
    @gjendja.reject! { |k, v| !(v[0] > 0)} 
    @gjendja = @gjendja.sort_by {|y, x| [y[2].data, y[2].id, y[1].to_i] }
    @totali_pesha = 0
    @totali_qmimi_tot = 0
    @totali_taksa_dogana = 0
    @totali_taksa_akciza = 0
    @totali_taksa_tvsh = 0
    @totali_gjithsej_taksat = 0
    @imports = []
    @gjendja.each do |k, v|
      @totali_pesha += v[1]
      @totali_qmimi_tot += v[2]
      @totali_taksa_dogana += v[4]
      @totali_taksa_akciza += v[5]
      @totali_taksa_tvsh += v[6]
      @totali_gjithsej_taksat += v[7]
      unless @imports.include? k[2]
        @imports.push k[2]
      end
    end
  end
  
end