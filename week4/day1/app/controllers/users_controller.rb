class UsersController < ApplicationController
  include UsersHelper
  
  def index
    render json: User.all
  end
  
  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end
  
  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: { "message"  =>  "Destroyed!" }
  end
  
  def favorites
    @user = User.find(params[:id])
    all_contacts = @user.contacts.where('favorite = true') +
                   @user.shared_contacts.where('contact_shares.favorite = true')
      
    
    render json: all_contacts
  end
end
