class Post < ActiveRecord::Base
  validates :title, :sub, :author, presence: true
  delegate :title, to: :sub, prefix: true
  delegate :username, to: :author, prefix: true
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id    
  )
  
  belongs_to(
    :sub,
    class_name: "Sub",
    foreign_key: :sub_id,
    primary_key: :id
  )
  
end
