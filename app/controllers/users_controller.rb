class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @user ||= User.new
    @errors = params[:errors]
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
  end
  
  def change_date
    @user = User.find(params[:id])
    @data_auto = @user.data_auto
    @data_gar = @user.data_gar
  end
  
  def change_date_post
    @user = User.find(params[:id])
    @user.data_auto = params[:useri][:data_auto]
    @user.data_gar = params[:useri][:data_gar]
    @user.save
    
    redirect_to root_path
    lajm
  end
  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        @errors = []
        if @user.errors.any?
          @user.errors.full_messages.each do |msg|
            @errors.push msg
          end
        end
        redirect_to users_path(errors: @errors)
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to settings_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :name, :numri_fiskal, :numri_biznesit, :numri_tvsh, :kategoria, :password, :password_confirmation)
    end
    
    def user_date_params
      params.require(:user).permit(:data_auto, :data_gar)
    end
end
