module UsersHelper 
  
  private
  def user_params
    params.require(:user).permit(:username)
  end
end
