class SessionsController < ApplicationController
  skip_before_action :go_login
  
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if !(user)
      flash[:danger] = 'Perdoruesi nuk ekziston.'
      redirect_to root_path
    elsif !(user.authenticate(params[:session][:password]))
      flash[:danger] = 'Fjalekalimi eshte Gabimi'
      redirect_to root_path
    elsif
      log_in(user)
      redirect_to home_path
    else
      flash[:danger] = "Diqka eshte Gabim"
      redirect_to root_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
