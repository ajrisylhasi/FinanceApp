class ProductPacketsController < ApplicationController
  def destroy
    @ep = ProductPacket.find(params[:id])
    @ep.destroy
    redirect_to @ep.packet
  end
end
