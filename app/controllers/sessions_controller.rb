class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]
  before_action :require_user!, only: [:destroy]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(session_params)
    if @user.nil?
      flash.now[:errors] = ["Invalid username/password combination"]
      @user = User.new(session_params)
      render :new
    else
      login_user!(@user)
      redirect_to user_url(@user)
    end
  end
  
  def destroy
    logout_user!
    redirect_to new_session_url
  end
  
  private
  
  def session_params
    params.require(:user).permit(:username, :password)
  end
  
end
