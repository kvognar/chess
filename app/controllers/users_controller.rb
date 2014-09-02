class UsersController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]
  before_action :require_user!, only: [:show]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    @new_goal = Goal.new
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
