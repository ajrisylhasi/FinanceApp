class PaletPacketsController < ApplicationController
  def destroy
    @pp = PaletPacket.find(params[:id])
    @pp.destroy
    redirect_to @pp.palet
  end
end
