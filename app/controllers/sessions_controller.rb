class SessionsController < ApplicationController
  skip_before_action :go_login
  
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if !(user)
      flash[:danger] = 'No User'
      redirect_to login_path
    elsif !(user.authenticate(params[:session][:password]))
      flash[:danger] = 'Wrong Password'
      redirect_to login_path
    elsif
      log_in(user)
      redirect_to root_path
    else
      flash[:danger] = "Something Wrong"
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
