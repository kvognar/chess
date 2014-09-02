class GoalsController < ApplicationController
  
  before_action :require_ownership!, only: [:show, :edit, :update, :destroy]
  
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      @user = @goal.user
      @new_goal = @goal
      render "users/show"
    end
  end
  
  def show
    @goal = Goal.find(params[:id])
  end
  
  def edit
    @goal = Goal.find(params[:id])
  end
  
  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user)
  end
  
  private

  def goal_params
    params.require(:goal).permit(:title, :description, :private, :completed)
  end
  
  def require_ownership!
    require_user!
    @goal = Goal.find(params[:id])
    unless @goal.user == current_user
      flash[:errors] = ["Forbidden"]
      redirect_to user_url(current_user) unless @goal.user == current_user
    end
  end
end
