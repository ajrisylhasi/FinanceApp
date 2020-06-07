class ListsController < ApplicationController
  def destroy
    @ia = List.find(params[:id])
    @ia.destroy
    zbritja_pack_p(@ia.packing_list)
    redirect_to @ia.packing_list
  end
end
