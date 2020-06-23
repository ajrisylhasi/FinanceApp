module MbylljasHelper
  def mbyllja(mby)
    mby.imports.each do |i|
      i.subs.each do |s|
        SubMbyllja.create(sub_id: s.id, mbyllja: mby, emertimi: s.import_gjendja.emertimi, pesha: s.mbetja_peshe, sasia: s.mbetja, qmimi: s.mbetja_qmimi)
        s.mbetja_peshe = 0
        s.mbetja = 0
        s.mbetja_qmimi = 0
        s.save
      end
      i.mbylled = true
      i.save
    end
  end
  
  def rikthim_mbyllja(mbyllja)
    mbyllja.imports.each do |i|
      i.subs.each do |s|
        sm = SubMbyllja.where(sub_id: s.id).first
        s.mbetja_peshe = sm.pesha
        s.mbetja = sm.sasia
        s.mbetja_qmimi = sm.qmimi
        s.save
      end
      i.mbylled = false
      i.mbyllja = nil
      i.save
    end
  end
end
