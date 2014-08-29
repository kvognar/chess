class UsersController < ApplicationController
  
  before_action :require_signed_out!, only: [:new, :create]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      # sign_in!(@user)
      render text: "You should receive an email shortly!"#user_url(@user)
    else
      render :new
    end
  end
  
  def activate
    @user = User.find_by_activation_token(params[:activation_token])
    @user.activated = true
    @user.save!
    sign_in!(@user)
    redirect_to root_url
  end
  
  def show
    @user = User.find_by_id(params[:id])
    render :show
  end
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
