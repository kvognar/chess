class CatRentalRequestsController < ApplicationController
  before_action :require_ownership!, only: [:approve, :deny, :destroy]
  before_action :require_signed_in!, only: [:create, :new]
  
  def new
    @cats = Cat.all
    @request = CatRentalRequest.new
    render :new
  end
  
  def create
    @request = CatRentalRequest.new(request_params)
    @request.renter = current_user
    if @request.save
      redirect_to cat_url(@request.cat)
    else
      render :new
    end
  end
  
  def destroy
    @request = CatRentalRequest.find(params[:id])
    @request.destroy
    redirect_to cat_url(@request.cat)
  end
  
  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat)
  end
  
  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_url(@request.cat)
  end
  
  def require_ownership!
    unless CatRentalRequest.find(params[:id]).cat.owner == current_user
      redirect_to cats_url 
    end
  end
  private
  
  def request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end
end
