class SessionsController < ApplicationController
  
  before_action :require_signed_out!, only: [:new, :create]
  before_action :require_signed_in!, only: [:destroy]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(session_params)
    if @user.nil?
      @user = User.new
      render :new
    else
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to user_url(@user)
    end
  end
  
  def destroy
    @user = current_user
    sign_out!(@user)
    redirect_to new_session_url
  end
  
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
