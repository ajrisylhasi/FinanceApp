class AutorizimProductsController < ApplicationController
  def destroy
    @aa = AutorizimProduct.find(params[:id])
    @aa.destroy
    redirect_to @aa.autorizim
  end
end
