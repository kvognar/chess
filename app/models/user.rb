class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true
  after_initialize :ensure_session_token
  
  has_many(
    :cats, 
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :sessions,
    class_name: "Session",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def self.find_by_credentials(credentials)
     user = User.find_by(user_name: credentials[:user_name])
     return nil if user.nil?
     return user if user.is_password?(credentials[:password])
     nil
  end
  
  def reset_session_token!
    self.sessions.destroy_all
    self.sessions.create!
  end
  
  def reset_single_session_token!(session_token)
    cur_session = Session.find_by_session_token(session_token)
    cur_session.destroy
    self.sessions.create!
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def ensure_session_token
    reset_session_token! if self.sessions.empty?
  end
  
end
