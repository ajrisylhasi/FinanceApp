class PackingListsController < ApplicationController
  def show 
    @packing_list = PackingList.find(params[:id])
    veprimi_pack(@packing_list)
    @packing_list.lists.build 
  end
  
  def update
    @packing_list = PackingList.find(params[:id])
    @export = @packing_list.export
    if params[:add_list]
      @packing_list.update_attributes(packing_list_params)
      zbritja_pack_p(@packing_list)
      redirect_to @packing_list
    else
      flash[:danger] = "Something Wrong"
      render 'show'
    end
  end
  
  
  private
  
    def packing_list_params
      params.require(:packing_list).permit(lists_attributes: [:id, :sasia, :packet_id, :_destroy])
    end
end
