class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
#  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def logged_in?
    current_user != nil
  end

  def login_user!(user)
    session[:token] = user.reset_session_token!
    @current_user = user
  end

  def logout_user!
    current_user.reset_session_token!
    session[:token] = nil
  end

  def require_user!
    redirect_to new_session_url unless logged_in?
  end

  def require_no_user!
    redirect_to user_url(current_user) if logged_in?
  end

end
