class NormativesController < ApplicationController
    before_action :find_normative, only: [:show, :edit, :update, :destroy, :file]
    
    def index
      @normatives = Normative.all
      
      @normative ||= Normative.new
      @errors = params[:errors]
    end
    
    def new
    end
    
    def create
      @normative = Normative.new(normative_params)
      if @normative.save
          redirect_to @normative
      else
        @errors = []
        if @normative.errors.any?
          @normative.errors.full_messages.each do |msg|
            @errors.push msg
          end
        end
        redirect_to normatives_path(errors: @errors)
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
        @tot_pesha_b = 0
        @tot_mbetja_peshe = 0
        @tot_pesha_n = 0

        @normative.normative_articles.each do |n|
          @tot_pesha_b += n.pesha_bruto
          @tot_mbetja_peshe += n.mbetja_ne_peshe
          @tot_pesha_n += n.pesha_neto
        end

        respond_to do |format|
          format.html
          format.json
          format.pdf { render template: "normatives/normativa.pdf", pdf: "Normativa-Nr-#{@normative.nr_normatives} - #{@normative.data}", orientation: 'Portrait' }
          
        end

        @normative.normative_articles.build
    end
    
    def files
      @normative = Normative.find(params[:id])
    end
    
    def edit
      @normative = Normative.find(params[:id])
    end
    
    def destroy
      @normative.destroy
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
