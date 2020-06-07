class PaletProductsController < ApplicationController
  def destroy
    @pp = PaletProduct.find(params[:id])
    @pp.destroy
    redirect_to @pp.palet
  end
end
