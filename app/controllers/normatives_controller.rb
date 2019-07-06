class NormativesController < ApplicationController
    before_action :find_normative, only: [:show, :edit, :update, :destroy, :file]
    
    def index
      @normatives = Normative.all
      
      @normative ||= Normative.new
    end
    
    def new
    end
    
    def create
      @normative = Normative.new(normative_params)
      if @normative.save
          flash[:succes] = "Normative successfuly updated"
          redirect_to @normative
      else
          render 'new'
      end
    end
    
    def test_normatives
      @normatives = Normative.all
    end
    
    def make_test
      
      @kategoria = params[:norm][:kategoria].to_s
      @normative = Normative.find(params[:norm][:normative_id]) rescue 0
      if @normative == 0 
        redirect_to change_path
      end
      @normative.kategoria = @kategoria
      @normative.save
      redirect_to settings_path
    end
    
    def show
        @normative = Normative.find(params[:id])
        @numri_rreshtave = @normative.normative_articles.count
        @pesha_b = @normative.pesha_b
        @pesha_n = @normative.pesha_n
        @mbetja_ne_sasi = @normative.mbetja_ne_sasi
        @mbetja_ne_peshe = @normative.mbetja_ne_peshe
        @pesha_neto = @normative.pesha_neto
        @sasia_neto = @normative.sasia_neto
        @normative.normative_articles.build
        respond_to do |format|
          format.html
          format.json
          format.pdf { render template: "normatives/normativa.pdf", pdf: "Normativa-Nr-#{@normative.nr_normatives} - #{@normative.data}", orientation: 'Portrait' }
          
        end
    end
    
    def files
      @normative = Normative.find(params[:id])
    end
    
    def edit
      @normative = Normative.find(params[:id])
    end
    
    def destroy
      @normative.destroy
      flash[:success] = "Normative deleted"
      redirect_to normatives_path
      
    end
    
    def update 
      @normative = Normative.find(params[:id])
      if params[:normative_article_add]
        @normative.update_attributes(normative_params)
        check_full @normative
        redirect_to @normative
      elsif @normative.update_attributes(normative_params)
        redirect_to @normative
      else
        render 'show'
      end
    end
    
    def delete_image_attachment
      @file = ActiveStorage::Attachment.find(params[:id])
      @file.purge
      redirect_back(fallback_location: request.referer)
    end

    private
    
      def normative_params
          params.require(:normative).permit( :product_id, :kategoria, :nr_normatives, :data, files: [], article_ids:[],
          normative_articles_attributes: [:id, :import_id, :article_id, :sasia, :pesha_bruto, :pesha_qmimi, :mbetja, :mbetja_peshe, :_destroy])
      end
      
      def find_normative
          @normative = Normative.find(params[:id])
      end
end
