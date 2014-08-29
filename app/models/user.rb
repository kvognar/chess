class User < ActiveRecord::Base
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: true
  validates :username, presence: true, uniqueness: true
  
  attr_reader :password
  
  after_initialize :ensure_token
  
  def self.find_by_credentials(credentials)
    @user = User.find_by_username(credentials[:username])
    @user && @user.is_password?(credentials[:password]) ? @user : nil
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def ensure_token
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
    self.session_token
  end
  
end
