class FeesController < ApplicationController
  def destroy
    @f = Fee.find(params[:id])
    @f.destroy
    redirect_to @f.fatura
  end
end
