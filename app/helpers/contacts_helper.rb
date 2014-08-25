module ContactsHelper
  
  private
  
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
  
end
