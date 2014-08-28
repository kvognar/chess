class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, null: false
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  
  attr_reader :password
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
end
