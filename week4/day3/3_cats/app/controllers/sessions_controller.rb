class SessionsController < ApplicationController
  before_action :require_signed_out!, only: [:new, :create]
  before_action :require_signed_in!,  only: [:destroy]
  
  def new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(session_params)
    unless @user.nil?
      login_user!(@user)
      redirect_to cats_url
    else
      render :new
    end
  end
  
  def destroy
    @user = current_user
    unless @user.nil?
      @user.reset_single_session_token!(session[:session_token])
      session[:session_token] = nil
    end
    redirect_to cats_url
  end
  
  private
  def session_params
    params.require(:session).permit(:user_name, :password)
  end
end
