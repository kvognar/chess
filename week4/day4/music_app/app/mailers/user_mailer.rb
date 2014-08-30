class UserMailer < ActionMailer::Base
  default from: "ghost@raspberry_jams.com"

  
  def welcome_email(user)
    @user = user
    @url = activate_users_url(activation_token: @user.activation_token,
                              host: "http://localhost:3000")
    mail(to: @user.email,
         subject: "Welcome to Raspberry Jams"
         )
  end
end
