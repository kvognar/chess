class Goal < ActiveRecord::Base
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true
  
  belongs_to :user
end
