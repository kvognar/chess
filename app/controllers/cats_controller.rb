class CatsController < ApplicationController
  before_action :require_ownership!, only: [:edit, :update, :destroy]
  before_action :require_signed_in!, only: [:new, :create]

  def index
    @cats = Cat.all.order(:name)
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    render :show
  end
  
  def new
    @cat = Cat.new
    render :new
  end
  
  def create
    @cat = Cat.new(cat_params)
    @cat.owner = current_user
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end
  
  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end
  
  def destroy
    Cat.delete(params[:id])
    redirect_to cats_url
  end
  
  private
  
  def require_ownership!
    redirect_to cats_url unless Cat.find(params[:id]).owner == current_user
  end
  
  def cat_params
    params
      .require(:cat)
      .permit(:name, :age, :sex, :birth_date, :color, :description)
  end
end
