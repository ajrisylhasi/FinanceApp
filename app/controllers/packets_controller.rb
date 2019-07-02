class PacketsController < ApplicationController
  before_action :find_packet, only: [:show, :edit, :update, :destroy]

  def index
    @packets = Packet.all
  end
  
  def new
    @packet ||= Packet.new
  end
  
  def create
      @packet = Packet.new(packet_params)
      if @packet.save
          flash[:success] = "Packet successfuly updated"
          redirect_to @packet
          
      else
          render 'new'
      end
  end
  
  def show
      @packet = Packet.find(params[:id])
      @packet.product_packets.build
  end
  
  def edit
      @packet = Packet.find(params[:id])
  end
  
  def destroy
      @packet.destroy
      flash[:success] = "Packet deleted"
      redirect_to packets_path
  end
  
  def update 
    @packet = Packet.find(params[:id])
    if @packet.update_attributes(packet_params)
      flash[:success] = "Packet successfuly updated"
      redirect_to @packet
    else
      render 'edit'
    end
  end
  
  def files
    @packet = Packet.find(params[:id])
  end
  
  def delete_image_attachment
    @file = ActiveStorage::Attachment.find(params[:id])
    @file.purge
    redirect_back(fallback_location: request.referer)
  end
  
  private
  
    def packet_params
        params.require(:packet).permit(:dimensioni, :nr_paketes,
        product_packets_attributes: [:id, :packet_id, :product_id, :sasia], files: [])
    end
    
    def find_packet
        @packet = Packet.find(params[:id])
    end
    
end