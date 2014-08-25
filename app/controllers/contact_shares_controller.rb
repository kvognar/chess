class ContactSharesController < ApplicationController
  include ContactSharesHelper
  
  def create
    @contact_share = ContactShare.new(contact_share_params)
    if @contact_share.save
      render json: @contact_share
    else
      render(json: @contact.errors.full_messages, 
        status: :unprocessable_entity)
    end
  end
  
  def destroy
    @contact_share = ContactShare.find(params[:id])
    @contact_share.destroy
    render json: @contact_share
  end
end
