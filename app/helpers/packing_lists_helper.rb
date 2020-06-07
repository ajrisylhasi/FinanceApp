module PackingListsHelper
  def refresh_pack_p(pack)
    hash = {}
    pack.lists.each do |l|
      l.packet.product_packets.each do |pp|
        if hash.keys.include? pp.product.pershkrimi
          hash[pp.product.pershkrimi] += pp.sasia * l.sasia
        else
          hash[pp.product.pershkrimi] = pp.sasia * l.sasia
        end
      end
    end
    pack.pack_gjendja = hash
  end
  
  def zbritja_pack_p(pack)
    export = pack.export
    export.pack_not = []
    once = false
    refresh_pack(export)
    refresh_pack_p(pack)
    if pack.pack_gjendja.count == 0
      export.pack_gjendja.each do |prod, sas|
        export.pack_not.push "Hala sjon rahatu krejt produktet #{prod} - #{sas} tjere tpa rahatun"
        once = true
      end
    end
    export.pack_gjendja.each do |prod, sas|
      if !(sas > 0) 
        next
      end
      if !once
        ska = pack.pack_gjendja.select { |prod_p, sas_p| prod == prod_p}
        if ska.count == 0
          export.pack_not.push "Hala sjon rahatu krejt produktet #{prod} - #{sas} tjere tpa rahatun"
        end
      end
      pack.pack_gjendja.each do |prod_p, sas_p|
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
    pack.save
    pack.export.save
  end
  
  def check_pack(pack)
    tot = true
    pack.export.pack_not.each do |notif|
      if notif.include? "sjon"
        tot = false
      end
    end
    tot
  end
  
  def veprimi_pack(pack)
    if pack.export.ndryshimi != pack.ndryshimi
      pack.ndryshimi = pack.export.ndryshimi
      zbritja_pack_p(pack)
    end
  end
end
