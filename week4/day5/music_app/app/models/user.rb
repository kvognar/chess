# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  
  attr_reader :password
  
  has_many(
    :authored_notes,
    class_name: "Note",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def self.find_by_credentials(credentials)
    user = User.find_by_email(credentials[:email])
    return nil if user.nil?
    user.is_password?(credentials[:password]) ? user : nil
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
