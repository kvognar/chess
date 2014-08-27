class Session < ActiveRecord::Base
  validates :session_token, :user_id, presence: true
  after_initialize :ensure_session_token
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def ensure_session_token
    self.session_token = SecureRandom::urlsafe_base64(16)
  end
  
end