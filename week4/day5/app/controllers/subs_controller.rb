class SubsController < ApplicationController
  before_action :ensure_logged_in!, only: [:show, :index]
  
  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.includes(:moderator, posts: :votes).find(params[:id])
    @posts = @sub.posts.sort { |a, b| b.score <=> a.score }
    render :show
  end
# .sort { |a, b| a.score <=> b.score }
  def index
    @subs = Sub.all
    render :index
  end
  
  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
