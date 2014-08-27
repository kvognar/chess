class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  helper_method :signed_in?
  
  def current_user
    return @current_user unless @current_user.nil?
    cur_session = Session.find_by(session_token: session[:session_token])
    if cur_session.nil?
      return nil
    else
      @current_user = cur_session.user
    end
  end
  
  def login_user!(user)
    new_session = user.sessions.create!
    session[:session_token] = new_session.session_token
  end
  
  def signed_in?
    current_user
  end
  
  def require_signed_in!
    redirect_to cats_url unless signed_in?
  end
  
  def require_signed_out!
    redirect_to cats_url if signed_in?
  end
  

end
