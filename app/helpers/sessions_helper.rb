module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def go_login
    unless logged_in?
      flash[:danger] = "Sta ka kakit dhomi"
      redirect_to login_path
    end
  end
  
  def access
    if logged_in?
      if current_user.kategoria == "limited"
        redirect_to reports_path
      end
    end
  end
end
