class ImportArticlesController < ApplicationController
  def destroy
    @ia = ImportArticle.find(params[:id])
    if @ia.import_gjendja.subs.count != 0
      wh_takes = Sub.all.where(import_gjendja: @ia.import_gjendja).sum(:sasia) + Sub.all.where(import_gjendja: @ia.import_gjendja).sum(:mbetja)
      wh_have = ImportGjendja.all.where(kodi: @ia.import_gjendja.kodi).where(emertimi: @ia.import_gjendja.emertimi).where(import: @ia.import).sum(:sasia) - @ia.import_gjendja.sasia
      wh_takes_psh = Sub.all.where(import_gjendja: @ia.import_gjendja).sum(:pesha) + Sub.all.where(import_gjendja: @ia.import_gjendja).sum(:mbetja_peshe)
      wh_have_psh = ImportGjendja.all.where(kodi: @ia.import_gjendja.kodi).where(emertimi: @ia.import_gjendja.emertimi).where(import: @ia.import).sum(:pesha) - @ia.import_gjendja.pesha
      wh_takes_qm = Sub.all.where(import_gjendja: @ia.import_gjendja).sum(:qmimi) + Sub.all.where(import_gjendja: @ia.import_gjendja).sum(:mbetja_qmimi)
      wh_have_qm = ImportGjendja.all.where(kodi: @ia.import_gjendja.kodi).where(emertimi: @ia.import_gjendja.emertimi).where(import: @ia.import).sum(:qmimi) - @ia.import_gjendja.qmimi
      if  wh_takes <= wh_have && wh_takes_psh <= wh_have_psh && wh_takes_qm <= wh_have_qm
        @ia.import_gjendja.subs.each do |s|
          sas = s.sasia
          mbt = s.mbetja
          psh = s.pesha
          mb_psh = s.mbetja_peshe
          qm = s.qmimi
          mb_qm = s.mbetja_qmimi
          s.export_gjendja.sasia += sas
          s.export_gjendja.mbetja += mbt
          s.export_gjendja.pesha += psh
          s.export_gjendja.mbetja_peshe += mb_psh
          s.export_gjendja.qmimi += qm
          s.export_gjendja.mbetja_qmimi += mb_qm
          s.export_gjendja.save
          zbritja_destroy(s.export_gjendja, @ia.import, @ia.article.kodi, @ia.emertimi, @ia.sasia, @ia.import_gjendja)
          @ia.destroy
          refresh_import(@ia.import)
          redirect_to @ia.import
        end
      else
        flash[:danger] = "Import being used and not replacable, add #{wh_takes - wh_have} #{@ia.article.njesia} #{@ia.article.pershkrimi} to Emertimi: #{@ia.emertimi} to resolve issue"
        redirect_to @ia.import
      end
    else
      @ia.destroy
      refresh_import(@ia.import)
      redirect_to @ia.import
    end
  end
end
