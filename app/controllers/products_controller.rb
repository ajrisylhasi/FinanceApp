class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  def index
    @products = Product.all
    @product ||= Product.new
    @errors = params[:errors]
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save 
      redirect_to @product
    else
      @errors = []
      if @product.errors.any?
        @product.errors.full_messages.each do |msg|
          @errors.push msg
        end
      end
      redirect_to products_path(errors: @errors)
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
    if @product.normatives.count > 0
      flash[:danger] = "There are normatives related to this product."
      redirect_to products_path
    else
      @product.destroy
      redirect_to products_path
    end
  end

  private
    
    def find_product 
      @product = Product.find(params[:id])
    end
    
    def product_params
      params.require(:product).permit(:pershkrimi, :articlenr, :tarif_kodi, :qmimi)
    end
  
end
