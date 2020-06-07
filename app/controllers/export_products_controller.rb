class ExportProductsController < ApplicationController
  def destroy
    @ep = ExportProduct.find(params[:id])
    @ep.export_gjendjas.each do |egj|
      egj.subs.each do |s|
        s.import_gjendja.sasia += (s.sasia + s.mbetja)
        s.import_gjendja.pesha += (s.pesha + s.mbetja_peshe)
        s.import_gjendja.qmimi += ( s.qmimi + s.mbetja_qmimi)
        s.import_gjendja.save
        bashkimi_importit(s.import_gjendja.import)
      end
    end
    @ep.destroy
    refresh_gjendja
    mbetja_bashkimi
    @ep.export.ndryshimi += 1
    @ep.export.save
    refresh_export(@ep.export)
    redirect_to @ep.export
  end
end
