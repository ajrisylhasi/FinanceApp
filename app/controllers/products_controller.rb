class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
    @product ||= Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save 
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private
    
    def find_product 
      @product = Product.find(params[:id])
    end
    
    def product_params
      params.require(:product).permit(:pershkrimi, :articlenr, :tarif_kodi, :qmimi)
    end
  
end
