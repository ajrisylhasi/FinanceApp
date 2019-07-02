class ClientsController < ApplicationController
  before_action :find_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
  end
  
  def new
    @client ||= Client.new
  end
  
  def create
      @client = Client.new(client_params)
      if @client.save
          flash[:success] = "Client successfuly updated"
          redirect_to @client
          
      else
          render 'new'
      end
  end
  
  def show
      @client = Client.find(params[:id])
      
  end
  
  def edit
      @client = Client.find(params[:id])
  end
  
  def destroy
      @client.destroy
      flash[:success] = "Client deleted"
      redirect_to clients_path
  end
  
  def update 
      @client = Client.find(params[:id])
      if @client.update_attributes(client_params)
        flash[:succes] = "Client successfuly updated"
        redirect_to @client
      else
        render 'edit'
      end
  end
  
  private
  
    def client_params
        params.require(:client).permit(:kompania, :shteti, :qyteti, :adresa, :numri_tel, :numri_fiskal, :numri_biz, :numri_tvsh,
        :konsignacioni, :shteti_k, :qyteti_k, :adresa_k, :numri_tel_k, :pack_category, :vat)
    end
    
    def find_client
        @client = Client.find(params[:id])
    end
end
